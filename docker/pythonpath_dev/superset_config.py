# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# This file is included in the final Docker image and SHOULD be overridden when
# deploying the image to prod. Settings configured here are intended for use in local
# development environments. Also note that superset_config_docker.py is imported
# as a final step as a means to override "defaults" configured here
#
import logging
import os
from datetime import timedelta
from typing import Optional, Any, Callable, Dict, List, Optional, Type, TYPE_CHECKING, Union, Literal # TODO: SWIGGY added extra imports

# from cachelib.file import FileSystemCache
from celery.schedules import crontab
# TODO: SWIGGY
# from superset import app
from boto3 import client
from botocore.exceptions import ClientError
from flask_appbuilder.security.manager import AUTH_OAUTH,AUTH_DB
# TODO: SWIGGY END

logger = logging.getLogger()


def get_env_variable(var_name: str, default: Optional[str] = None) -> str:
    """Get the environment variable or raise exception."""
    try:
        return os.environ[var_name]
    except KeyError:
        if default is not None:
            return default
        else:
            error_msg = "The environment variable {} was missing, abort...".format(
                var_name
            )
            raise EnvironmentError(error_msg)


DATABASE_DIALECT = get_env_variable("DATABASE_DIALECT")
DATABASE_USER = get_env_variable("DATABASE_USER")
DATABASE_PASSWORD = get_env_variable("DATABASE_PASSWORD")
DATABASE_HOST = get_env_variable("DATABASE_HOST")
DATABASE_PORT = get_env_variable("DATABASE_PORT")
DATABASE_DB = get_env_variable("DATABASE_DB")

# The SQLAlchemy connection string.
SQLALCHEMY_DATABASE_URI = "%s://%s:%s@%s:%s/%s" % (
    DATABASE_DIALECT,
    DATABASE_USER,
    DATABASE_PASSWORD,
    DATABASE_HOST,
    DATABASE_PORT,
    DATABASE_DB,
)

print("getting sql alchemy engine in superset config", SQLALCHEMY_DATABASE_URI)

REDIS_HOST = get_env_variable("REDIS_HOST")
REDIS_PORT = get_env_variable("REDIS_PORT")
REDIS_CELERY_DB = get_env_variable("REDIS_CELERY_DB", "0")
REDIS_RESULTS_DB = get_env_variable("REDIS_RESULTS_DB", "1")

# TODO: SWIGGY
# RESULTS_BACKEND = FileSystemCache("/app/superset_home/sqllab")
# TODO: SWIGGY END


class CeleryConfig(object):
    BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_CELERY_DB}"
    CELERY_IMPORTS = ("superset.sql_lab",)
    CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_RESULTS_DB}"
    CELERYD_LOG_LEVEL = "DEBUG"
    CELERYD_PREFETCH_MULTIPLIER = 1
    CELERY_ACKS_LATE = False
    CELERYBEAT_SCHEDULE = {
        "reports.scheduler": {
            "task": "reports.scheduler",
            "schedule": crontab(minute="*", hour="*"),
        },
        "reports.prune_log": {
            "task": "reports.prune_log",
            "schedule": crontab(minute=10, hour=0),
        },
    }


CELERY_CONFIG = CeleryConfig

FEATURE_FLAGS = {"ALERT_REPORTS": True}
ALERT_REPORTS_NOTIFICATION_DRY_RUN = True
WEBDRIVER_BASEURL = "http://superset:8088/"
# The base URL for the email report hyperlinks.
# TODO: SWIGGY
WEBDRIVER_BASEURL_USER_FRIENDLY = get_env_variable("WEBDRIVER_BASEURL_USER_FRIENDLY", "http://superset:8088/")
#TODO: SWIGGY END

SQLLAB_CTAS_NO_LIMIT = True

#
# Optionally import superset_config_docker.py (which will have been included on
# the PYTHONPATH) in order to allow for local settings to be overridden
#
try:
    import superset_config_docker
    from superset_config_docker import *  # noqa

    logger.info(
        f"Loaded your Docker configuration at " f"[{superset_config_docker.__file__}]"
    )
except ImportError:
    logger.info("Using default Docker config...")

# TODO: SWIGGY override configs here
ENABLE_PROXY_FIX = True
PROXY_FIX_CONFIG = {"x_for": 1, "x_proto": 2, "x_host": 1, "x_port": 0, "x_prefix": 1}
SUPERSET_WEBSERVER_ADDRESS = get_env_variable("SUPERSET_WEBSERVER_ADDRESS", "0.0.0.0")
SUPERSET_WEBSERVER_TIMEOUT = 30
WTF_CSRF_ENABLED = False
APP_NAME = "Swiggy-Compass"
APP_ICON_WIDTH = 126

auth_types = {
    'AUTH_OID': 0,
    'AUTH_DB': 1,
    'AUTH_LDAP': 2,
    'AUTH_REMOTE_USER': 3,
    'AUTH_OAUTH': 4
}
AUTH_TYPE = auth_types.get(get_env_variable("AUTH_TYPE", AUTH_OAUTH))

AUTH_USER_REGISTRATION = True

def read_auth_roles_locally() -> Dict:
    json_data = {}
    print("In read_auth_roles_locally method")
    try:
        with open('superset/auth_roles_mapping.json') as f:
            data = f.read()
        json_data = json.loads(data)
        print(json_data)

    except EnvironmentError as e:
        print('Error in reading auth_roles_mapping local file: ', e)
    return json_data

def auth_roles_mapping() -> Dict:
    json_data = {}
    BUCKET = 'swiggy-smart-products-prod'
    FILE_TO_READ = 'compass/auth_roles_mapping.json'
    try:
        print("In Auth_Roles_Mapping method")
        print("bucket_name: %s", get_env_variable('COMPASSWEBSERVICES3_BUCKETNAME', BUCKET))

        config = Config(
            retries={
                'max_attempts': 5,
                'mode': 'standard'
            }
        )
        s3_client = client('s3', config=config)
        file_content = s3_client.get_object(Bucket=get_env_variable(
            'COMPASSWEBSERVICES3_BUCKETNAME', BUCKET), Key=FILE_TO_READ)[
            "Body"].read().decode('utf-8')
        json_data = json.loads(file_content)
        print(json_data)

    except (Exception) as e:
        print('Error in reading auth_roles_mapping file: ', e)
        return read_auth_roles_locally()
    return json_data

# AUTH_ROLES_MAPPING = auth_roles_mapping()


# The default user self registration role
AUTH_USER_REGISTRATION_ROLE = "Gamma_Swiggy"

OAUTH_PROVIDERS = [
    {
        "name": "azure",
        "icon": "fa-windows",
        "token_key": "access_token",
        "remote_app": {
            "client_id": os.environ.get("AZURE_APPLICATION_ID"),
            "client_secret": os.environ.get("AZURE_SECRET"),
            "api_base_url": "https://login.microsoftonline.com/{AZURE_TENANT_ID}/oauth2",
            "client_kwargs": {
                "scope": "User.read name preferred_username email profile upon",
                "resource": os.environ.get("AZURE_APPLICATION_ID"),
            },
            "request_token_url": None,
            "access_token_url": "https://login.microsoftonline.com/830534c3-5672-4618-bd49-82e8af727e64/oauth2/token",
            "authorize_url": "https://login.microsoftonline.com/830534c3-5672-4618-bd49-82e8af727e64/oauth2/authorize",
        },
    }
]

AUTH_STRICT_RESPONSE_CODES = True # copying directly from old config
PUBLIC_ROLE_LIKE: Optional[str] = "Gamma"
DASHBOARD_AUTO_REFRESH_MODE: Literal["fetch", "force"] = "fetch"
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_SAMESITE = None
GUEST_TOKEN_JWT_EXP_SECONDS = 3600 # 1 hour

