from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Conexão com o banco de dados MySQL
def get_db_connection():
    conexao = mysql.connector.connect(
        host='localhost',
        user='root',
        password='sua_senha',
        database='norte_saber'
    )
    return conexao

@app.route('/api/login', methods=['POST'])
def login():
    dados = request.json
    email = dados.get('email')
    senha = dados.get('senha')

    try:
        conexao = get_db_connection()
        cursor = conexao.cursor(dictionary=True)
        
        # Consulta SQL para verificar o usuário
        cursor.execute("SELECT id_usuario, nome, tipo_usuario FROM usuarios WHERE email = %s AND senha = %s", (email, senha))
        usuario = cursor.fetchone()
        
        cursor.close()
        conexao.close()

        if usuario:
            return jsonify({"mensagem": "Login aprovado!", "usuario": usuario}), 200
        else:
            return jsonify({"mensagem": "Credenciais inválidas"}), 401
            
    except Exception as e:
        return jsonify({"erro": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)