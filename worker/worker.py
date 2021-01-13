import json
import requests
import os
from time import sleep
from random import randint

numero_de_requisicoes = randint(10, 20)
ip_localhost = '192.168.0.14'

print("aguardando inicialização do app_1...")
sleep(10)
print("iniciando loop de", numero_de_requisicoes, "requisições...")

for requisicao_numero in range(numero_de_requisicoes):
    request = requests.get(''.join(["http://", ip_localhost, ":3000/"]))
    print("requisição nº ", requisicao_numero, "status code: ", request.status_code)
    sleep(1)

print('PRONTO PARA DALHE')