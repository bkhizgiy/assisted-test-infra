from dataclasses import dataclass

from assisted_test_infra.test_infra.helper_classes.config.controller_config import BaseNodeConfig


@dataclass
class OVirtControllerConfig(BaseNodeConfig):
    ovirt_cluster_id: str = None
    ovirt_fqdn: str = None
    ovirt_username: str = None
    ovirt_password: str = None
    ovirt_ca_bundle: str = None
    ovirt_insecure: bool = True
    ovirt_storage_domain_id: str = None
    ovirt_storage_domain_name: str = None
    ovirt_network: str = None
    ovirt_vnic_profile: str = None

    def __post_init__(self):
        super().__post_init__()
