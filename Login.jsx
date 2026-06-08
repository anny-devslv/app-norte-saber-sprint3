import { useState } from 'react';

export default function Login() {
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');

  const handleLogin = (e) => {
    e.preventDefault();
    // Lógica de validação dos campos de entrada
    if (email && senha) {
      console.log("Tentativa de login para:", email);
      // Chamada simulada para a API em Python
      alert("Login efetuado com sucesso! Redirecionando para o Dashboard...");
    } else {
      alert("Por favor, preencha o e-mail e a senha.");
    }
  };

  return (
    <div className="login-container">
      <h2>Bem-vindo de volta ao Norte Saber</h2>
      <form onSubmit={handleLogin}>
        <label>E-mail</label>
        <input 
          type="email" 
          value={email} 
          onChange={(e) => setEmail(e.target.value)} 
          required 
        />
        
        <label>Senha</label>
        <input 
          type="password" 
          value={senha} 
          onChange={(e) => setSenha(e.target.value)} 
          required 
        />
        
        <button type="submit">Entrar</button>
      </form>
    </div>
  );
}