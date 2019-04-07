

import time
from apns import APNs, Frame, Payload

apns = APNs(use_sandbox=True, cert_file='publish.pem', key_file='private.pem')
          
# Send a notification
token_hex = '2d76dc6e00d1cab8e764f8095461ab04a2fb4f4ba153a5506916d718307cf51e'

payload = Payload(alert="Hello World!", sound="default", badge=1)

apns.gateway_server.send_notification(token_hex, payload)

