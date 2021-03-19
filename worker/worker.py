import json
import requests
import os
from time import sleep
from random import randint

numero_de_requisicoes = 50
ip_localhost = '192.168.0.14'

print("aguardando inicialização do app_1...")
sleep(5)
print("iniciando loop de", numero_de_requisicoes, "requisições...")

for requisicao_numero in range(numero_de_requisicoes):
    request_number = requisicao_numero + 1
    request = requests.get(''.join(["http://", ip_localhost, ":3000/"]), params={'request_number': (request_number+1)})
    print("requisição nº", request_number, "status code:", request.status_code, "response: ", request.text)
    sleep(1)

print('encerrando worker...')