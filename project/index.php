<?php 

//phpinfo();
//die;

// Dados de conexão do banco de dados
$dsn = 'pgsql:host=postgres;dbname=postgres;user=postgres;password=teste21';

try {
    // Cria uma nova conexão PDO
    $pdo = new PDO($dsn);

    // Configura o modo de erro do PDO para lançar exceções
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Exibe uma mensagem de sucesso
    echo "Conexão bem-sucedida via postgre!";
} catch(PDOException $e) {
    // Em caso de erro, exibe a mensagem de erro
    die("Erro na conexão: " . $e->getMessage());
}
