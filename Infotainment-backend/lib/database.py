import logging
from typing import Dict

import psycopg2


class ConnectionHandler:
    _connection = None

    def __init__(self, hostname: str, port: str, username: str, password: str, database: str):
        self._connection = psycopg2.connect(
            host=hostname,
            port=port,
            user=username,
            password=password,
            dbname=database
        )
        logging.info(f"DB: Connected to database: '{hostname}:{port}/{database}' with user '{username}'")

    def update_vehicle(self, vehicle_id: str, vehicle: {}, columns: []) -> [bool, Dict]:
        # create partial update with only relevant columns!
        set_part = [f"   {col} = {vehicle[col]} " for col in columns]
        set_part = ',\n'.join(set_part)
        update_query = f"UPDATE vehicle_state \nSET \n{set_part} \nWHERE vehicle_id = '{vehicle_id}';"
        logging.info(f'Command: Update: query:\n{update_query}')

        try:
            with self._connection as conn:
                cursor = conn.cursor()
                # start transaction & lock entry
                _, _ = self.check_vehicle(vehicle_id=vehicle_id, cursor=cursor, raise_exception=True)
                # update entry
                cursor.execute(update_query)
                # fetch again
                _, updated_vehicle = self.check_vehicle(vehicle_id=vehicle_id, cursor=cursor, raise_exception=True)
                # commit is by default
            return True, updated_vehicle
        except Exception as e:
            logging.error(f'Error in ConnectionHandler.update_vehicle(...) method: {e}')
            return [False, None]

    def create_vehicle(self, vehicle_id: str) -> [bool, Dict]:
        try:
            # no need for transactions and locking
            exists, vehicle = self.check_vehicle(vehicle_id)
            if exists:
                return [False, vehicle]
            cursor = self._connection.cursor()
            cursor.execute(
                "INSERT INTO vehicle_state "
                "(vehicle_id, dpf_warning, battery_level, rpm, velocity) "
                "VALUES ('{}', {}, {}, {}, {});".format(vehicle_id, 'FALSE', 100, 0, 0)
            )
            return self.check_vehicle(vehicle_id)
        except Exception as e:
            logging.error(f'Error in ConnectionHandler.create_vehicle(...) method: {e}')
            return [False, None]

    def check_vehicle(self, vehicle_id: str, cursor=None, raise_exception: bool = False) -> [bool, Dict]:
        if not cursor:
            cursor = self._connection.cursor()
        # if cursor is sent, then transaction already started so 'FOR UPDATE' lock needs to be used!
        cursor.execute("SELECT * "
                       "FROM vehicle_state "
                       f"WHERE vehicle_id = '{vehicle_id}' "
                       f"{'FOR UPDATE' if cursor else ''};")
        return ConnectionHandler._map_vehicle(cursor=cursor, raise_exception=raise_exception)

    def close(self) -> bool:
        if self._connection is None:
            return False
        self._connection.close()
        logging.info('DB: Connection to database: Closed')
        return True

    @staticmethod
    def _map_vehicle(cursor, raise_exception: bool) -> [bool, Dict]:
        result: bool = False if cursor is None else cursor.rowcount > 0
        vehicle: {} = {}
        if result:
            t = cursor.fetchone()
            vehicle = {
                'vehicle_id': t[0],
                'dpf_warning': t[1],
                'battery_level': float(t[2]) if t[2] else t[2],
                'rpm': float(t[3]) if t[3] else t[3],
                'velocity': float(t[4]) if t[4] else t[4],
                'created_at': t[5],
                'updated_at': t[6]
            }
        elif raise_exception:
            raise Exception(f"Vehicle wasn't found!")
        return result, vehicle
