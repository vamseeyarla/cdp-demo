#
# System Imports
#
import logging
from keycloak import KeycloakAdmin


#
# Local Imports
#


#
# Global Variables
#
logger = logging.getLogger(__name__)


class KC_Wrapper():
    """
    Configures Keycloak for DPS based on the input parameters and config
    values
    Input Parameters: Keycloak Configuration File
    Returns: class object
    """
    def __init__(self, kc_url, kc_admin_user, kc_admin_password,
                 realm_name='master'):
        """ Init Constructor """
        self.keycloak_url = kc_url
        self.keycloak_usr = kc_admin_user
        self.keycloak_pwd = kc_admin_password
        # Let's create a Keycloak connection here
        self.k_admin = KeycloakAdmin(server_url=kc_url + '/auth/',
                                     username=kc_admin_user,
                                     password=kc_admin_password,
                                     realm_name=realm_name,
                                     verify=False)
        logger.debug("Token created: %s" % self.k_admin.token)

    def set_realm_on_keycloak(self, realm_name):
        """
        Wrapper function to set the realm name on Keycloak
        """
        self.k_admin.realm_name = realm_name

    def create_user_on_keycloak(self, user_name):
        """
        Creates user on keycloak side
        """
        try:
            user_email = user_name + '@eastwestbank.com'
            self.k_admin.create_user(
                {
                    "email": user_email,
                    "username": user_name,
                    "enabled": True,
                    "firstName": user_name,
                    "lastName": user_name,
                    "requiredActions": [],
                    "credentials": [
                        {
                            "value": 'Cloudera1!',
                            "type": "password"
                        }]
                })
            logger.debug("User: %s created !!!" % user_name)
            return True
        except Exception as e:
            logger.exception("Exception caught while creating user: %s" % e)
            return False

    def create_group_on_keycloak(self, group_name):
        """
        Creates group on keycloak side
        """
        try:
            self.k_admin.create_group(
                {
                    "name": group_name,
                    "path": ''
                })
            logger.debug("Group: %s created !!!" % group_name)
            return True
        except Exception as e:
            logger.exception("Exception caught while creating group: %s" % e)
            return  False

    def add_user_to_group(self, user_name, group_name):
        """
        Creates group on keycloak side
        """
        try:
            user_id = self.k_admin.get_user_id(user_name)
            group_id = self.k_admin.get_group_by_path('/'+group_name)["id"]
            print("Found user %s" % user_id)
            print("Found group %s" % group_id)
            self.k_admin.group_user_add(user_id, group_id)
            logger.debug("Added User %s to Group: %s", user_name, group_name)
            return True
        except Exception as e:
            logger.exception("Exception caught while adding user to group: %s" % e)
            return  False

if __name__ == "__main__":
    logging.basicConfig()
    keycloak_obj = KC_Wrapper('https://34.221.41.8:8443', 'admin', 'Cloudera1!')
    keycloak_obj.set_realm_on_keycloak('eastwestbank')


    assert keycloak_obj.create_user_on_keycloak('john_finance')
    assert keycloak_obj.create_user_on_keycloak('mark_bizdev')
    assert keycloak_obj.create_user_on_keycloak('jeremy_contractor')
    assert keycloak_obj.create_user_on_keycloak('diane_csr')
    assert keycloak_obj.create_user_on_keycloak('etl_user')
    assert keycloak_obj.create_user_on_keycloak('log_monitor')

    assert keycloak_obj.create_user_on_keycloak('michelle_dpo')
    assert keycloak_obj.create_user_on_keycloak('ivanna_eu_hr')
    assert keycloak_obj.create_user_on_keycloak('sasha_eu_hr')
    assert keycloak_obj.create_user_on_keycloak('kate_hr')
    assert keycloak_obj.create_user_on_keycloak('joe_analyst')

    assert keycloak_obj.create_group_on_keycloak('intern')
    assert keycloak_obj.create_group_on_keycloak('etl')
    assert keycloak_obj.create_group_on_keycloak('csr')
    assert keycloak_obj.create_group_on_keycloak('contractor')
    assert keycloak_obj.create_group_on_keycloak('finance')
    assert keycloak_obj.create_group_on_keycloak('business_dev')

    assert keycloak_obj.create_group_on_keycloak('dpo')
    assert keycloak_obj.create_group_on_keycloak('hr')
    assert keycloak_obj.create_group_on_keycloak('analyst')
    assert keycloak_obj.create_group_on_keycloak('eu_employee')
    assert keycloak_obj.create_group_on_keycloak('us_employee')

    assert keycloak_obj.add_user_to_group('joe_analyst', 'analyst')
    assert keycloak_obj.add_user_to_group('john_finance', 'finance')
    assert keycloak_obj.add_user_to_group('mark_bizdev', 'business_dev')
    assert keycloak_obj.add_user_to_group('jeremy_contractor', 'contractor')
    assert keycloak_obj.add_user_to_group('diane_csr', 'csr')
    assert keycloak_obj.add_user_to_group('etl_user', 'etl')
    assert keycloak_obj.add_user_to_group('log_monitor', 'etl')
    assert keycloak_obj.add_user_to_group('michelle_dpo', 'dpo')
    assert keycloak_obj.add_user_to_group('ivanna_eu_hr', 'hr')
    assert keycloak_obj.add_user_to_group('sasha_eu_hr', 'hr')
    assert keycloak_obj.add_user_to_group('kate_hr', 'hr')
    assert keycloak_obj.add_user_to_group('kate_hr', 'us_employee')
    assert keycloak_obj.add_user_to_group('ivanna_eu_hr', 'eu_employee')
    assert keycloak_obj.add_user_to_group('sasha_eu_hr', 'eu_employee')
    assert keycloak_obj.add_user_to_group('joe_analyst', 'us_employee')
    assert keycloak_obj.add_user_to_group('michelle_dpo', 'eu_employee')
