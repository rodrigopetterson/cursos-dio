#!/bin/bash
# *********************************************
# * Criacao de usuario  2.0                   *
# * Author: Rodrigo Petterson                 *
# * E-Mail: contato@linksky.com.br            *
# * Date: 20-08-2022                          *
# *********************************************

# Indicando o inicio do script:
echo
echo -e "\033[1;5;91m" +---------------------------------------------------+ "\033[m"
echo -e "\033[1;5;91m" +  Começando execução Script de criação de usuarios!  + "\033[m"
echo -e "\033[1;5;91m" +---------------------------------------------------+ "\033[m"
sleep 5
echo
echo "Seu nome de usuário é:"
echo -e "\033[1;34m" $(whoami) "\033[m"
echo
echo "Info de hora atual e tempo que o computador está ligado:"
echo -e "\033[1;34m" $(uptime | cut -d, -f1) "\033[m"
echo
echo "O script está executando do diretório:"
echo -e "\033[1;34m" $(pwd) "\033[m"
echo
sleep 3
#Criacao de usuarios linux.

# Declare o Array statico (setores e usuarios)

declare -a setor="('publico' 'adm' 'ven' 'sec')"
declare -a user${setor[1]}="('carlos' 'maria' 'joao')"
declare -a user${setor[2]}="('debora' 'sebastiana' 'roberto')"
declare -a user${setor[3]}="('josefina' 'amanda' 'rogerio')"

# Se quizer alterar o caminho absoluto do novo diretorio

raiz='/'
usuarios='/etc/passwd'
grupos='/etc/group'

#  FUNÇÕES DO SCRIPT

function linha {
        echo "______________________________________________________________________"
        echo
}

function mostra() {
        echo  $1
        
}

# Tarefa do script do shell

# CRIAÇÃO DE DIRETORIOS

        linha
        mostra "Criando diretorios... "
        linha
        for dir in ${setor[*]}; do
        mkdir -v "$raiz${dir}" | cut -d: -f2;
        done;
        linha

# CRIAÇÃO DE GRUPOS

        echo "Criando grupos de usúarios... "
        linha
        for G in ${setor[*]:1}; do
        groupadd  GRP_${G^^} | cut -d: -f2;
        echo "GRP_${G^^}"
        done;
        linha

# CRIAÇÃO DE USUARIOS

        echo "Criando usúarios... "
        linha
        for user in ${useradm[*]}; do
        useradd -m ${user} -c "Usuario de ${setor[1]^^}" -p $(openssl passwd -1 ${user}@123) -s /bin/bash -G "GRP_${setor[1]^^}";
        echo "[Ok] usuário [$user] foi criado e adicionado no grupo GRP_${setor[1]^^}"
       done;
        for user in ${userven[*]}; do
        useradd -m ${user} -c "Usuario de ${setor[2]^^}" -p $(openssl passwd -1 ${user}@123) -s /bin/bash -G "GRP_${setor[2]^^}";
        echo "[Ok] usuário [$user] foi criado e adicionado no grupo GRP_${setor[2]^^}"
       done;
        for user in ${usersec[*]}; do
        useradd -m ${user} -c "Usuario de ${setor[3]^^}" -p $(openssl passwd -1 ${user}@123) -s /bin/bash -G "GRP_${setor[3]^^}";
        echo "[Ok] usuário [$user] foi criado e adicionado no grupo GRP_${setor[3]^^}"
       done;
        linha

# PERMISSÕES DE DIRETORIO

        echo "Especificando permissões dos diretorios... "
        linha
        for P in ${setor[*]:1}; do
        chown -v root:GRP_${P^^} $raiz${P};
        chmod 770 $raiz${P}
        echo "Diretorio '$raiz${P}' permissao full para dono:grupo negado outros"
        echo
        done;
        chmod 777 $raiz${setor}
        echo "Diretorio '$raiz${setor}' premissao full"
        linha

# VERIFICAÇÃO DE CRIAÇÃO

        echo "Verificando Usuário(s) Criado(s):"
        linha
        for vu in ${useradm[*]}; do
            echo -e "[OK]  $(egrep ${vu} $usuarios | cut -d: -f1)";
        done;
        for vu in ${userven[*]}; do
            echo -e "[OK]  $(egrep ${vu} $usuarios | cut -d: -f1)";
        done;
        for vu in ${usersec[*]}; do
            echo -e "[OK]  $(egrep ${vu} $usuarios | cut -d: -f1)";
        done;
        linha
        echo "Vericando Grupo(s) Criado(s):"
        linha
        for vg in ${setor[*]:1}; do
            echo -e "[OK]  $(egrep ${vg^^} $grupos | cut -d: -f1)";
        done;
        linha
        echo "Verificando Diretorios e permissões dadas... "
        linha
        for dir in ${setor[*]}; do
            echo -e "[OK]  $(ls -lha $raiz | egrep ${dir})";
        done;
        linha


# Indicando o fim do script:

        echo -e "\033[1;5;92m" +-------------------------------+ "\033[m"
        echo -e "\033[1;5;92m" +  Script executado com sucesso!  + "\033[m"
        echo -e "\033[1;5;92m" +-------------------------------+ "\033[m"
        echo
