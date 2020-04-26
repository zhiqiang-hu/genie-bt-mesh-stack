NAME := light

$(NAME)_COMPONENTS  += genie_app bluetooth.bt_host bluetooth.bt_mesh yloop cli

$(NAME)_INCLUDES += ../../../../genie_app \
					../../../../genie_app/base \
					../../../../genie_app/bluetooth/host \
					../../../../genie_app/bluetooth/mesh

$(NAME)_SOURCES  := light.c

ifeq ($(HOST_MCU_FAMILY),ch6121)
bt_host_tinycrypt = 0
else ifeq ($(HOST_MCU_FAMILY),tg7100b)
bt_host_tinycrypt = 0
else
ble = 1
bt_mesh = 1
endif
en_bt_smp = 1

# Host configurations
GLOBAL_DEFINES += CONFIG_BLUETOOTH
ifeq ($(HOST_MCU_FAMILY),ch6121)
GLOBAL_DEFINES += CONFIG_BT_RX_BUF_LEN=252
GLOBAL_DEFINES += CONFIG_BT_L2CAP_TX_MTU=244
GLOBAL_DEFINES += CONFIG_BT_MESH_ADV_BLOCK
else ifeq ($(HOST_MCU_FAMILY),tg7100b)
GLOBAL_DEFINES += CONFIG_BT_RX_BUF_LEN=252
GLOBAL_DEFINES += CONFIG_BT_L2CAP_TX_MTU=244
GLOBAL_DEFINES += CONFIG_BT_MESH_ADV_BLOCK
else
GLOBAL_DEFINES += CONFIG_BT_SMP
GLOBAL_DEFINES += CONFIG_BT_HCI_VS_EXT
GLOBAL_DEFINES += CONFIG_BT_TINYCRYPT_ECC
endif
GLOBAL_DEFINES += CONFIG_BT_CONN
#GLOBAL_DEFINES += CONFIG_BT_CENTRAL
GLOBAL_DEFINES += CONFIG_BT_PERIPHERAL
#GLOBAL_DEFINES += CONFIG_BLE_50


# Mesh function select
GLOBAL_DEFINES += CONFIG_BT_MESH
GLOBAL_DEFINES += CONFIG_BT_MESH_PROV
GLOBAL_DEFINES += CONFIG_BT_MESH_PB_ADV
GLOBAL_DEFINES += CONFIG_BT_MESH_PB_GATT
GLOBAL_DEFINES += CONFIG_BT_MESH_PROXY
GLOBAL_DEFINES += CONFIG_BT_MESH_GATT_PROXY
GLOBAL_DEFINES += CONFIG_BT_MESH_RELAY
#GLOBAL_DEFINES += CONFIG_BT_MESH_FRIEND
#GLOBAL_DEFINES += CONFIG_BT_MESH_LOW_POWER
#GLOBAL_DEFINES += CONFIG_BT_MESH_SHELL
#GLOBAL_DEFINES += CONFIG_BT_MESH_BQB
#GLOBAL_DEFINES += CONFIG_BT_MESH_IV_UPDATE_TEST

# Mesh foundation model select
GLOBAL_DEFINES += CONFIG_BT_MESH_CFG_SRV
GLOBAL_DEFINES += CONFIG_BT_MESH_HEALTH_SRV

# Mesh debug message enable
#GLOBAL_DEFINES += USE_BT_MESH_CUSTOM_LOG
ifeq ($(HOST_MCU_FAMILY),ch6121)
GLOBAL_DEFINES += GENIE_DEBUG_COLOR
#GLOBAL_DEFINES += MESH_DEBUG_RX
#GLOBAL_DEFINES += MESH_DEBUG_TX
#GLOBAL_DEFINES += MESH_DEBUG_PROV
else ifeq ($(HOST_MCU_FAMILY),tg7100b)
GLOBAL_DEFINES += GENIE_DEBUG_COLOR
GLOBAL_DEFINES += MESH_DEBUG_RX
GLOBAL_DEFINES += MESH_DEBUG_TX
GLOBAL_DEFINES += MESH_DEBUG_PROV
else
GLOBAL_DEFINES += GENIE_DEBUG_COLOR
GLOBAL_DEFINES += MESH_DEBUG_RX
GLOBAL_DEFINES += MESH_DEBUG_TX
GLOBAL_DEFINES += MESH_DEBUG_PROV
endif
#GLOBAL_DEFINES += CONFIG_INIT_STACKS
#GLOBAL_DEFINES += CONFIG_PRINTK

GLOBAL_INCLUDES += ../

GLOBAL_DEFINES += CONFIG_BT_DEVICE_NAME=\"light\"

GLOBAL_DEFINES += PROJECT_SW_VERSION=0x00010004
GLOBAL_DEFINES += PROJECT_SECRET_KEY=\"00112233445566770011223344556677\"

####### ota config #######
GENIE_OTA = 1

MESH_MODEL_GEN_ONOFF_SRV = 1
#MESH_MODEL_DIABLE_TRANS = 1
MESH_MODEL_LIGHTNESS_SRV = 1
MESH_MODEL_CTL_SRV = 1
MESH_MODEL_VENDOR_SRV = 1
ALI_SIMPLE_MODLE = 1

GLOBAL_DEFINES += GENIE_OLD_AUTH
GLOBAL_DEFINES += GENIE_ULTRA_PROV

ifeq ($(HOST_MCU_FAMILY),ch6121)
MESH_MODEL_VENDOR_TIMER = 1
else ifeq ($(HOST_MCU_FAMILY),tg7100b)
MESH_MODEL_VENDOR_TIMER = 1
endif

