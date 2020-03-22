## Roteiro passo a passo de como criar um projeto do início ao fim utilizando a abordagem Database First do Entity Framework Core 2.1.

### Neste exemplo foi criado um sistema para gerenciamento de pacotes de viagens.



# 1. Criar a estrutura do banco de dados (01_Senatur_BD_DDL.sql)

```sql
-- Cria o banco de dados
CREATE DATABASE Senatur_DataBaseFirst;
GO

-- Define qual banco de dados será utilizado
USE Senatur_DataBaseFirst;
GO

-- Cria as tabelas
CREATE TABLE TiposUsuario(
IdTipoUsuario		INT PRIMARY KEY IDENTITY
,Titulo                 VARCHAR (255) UNIQUE NOT NULL
);
GO

CREATE TABLE Usuarios(
IdUsuario		INT PRIMARY KEY IDENTITY
,Email			VARCHAR (255) UNIQUE NOT NULL
,Senha			VARCHAR (255) NOT NULL
,IdTipoUsuario	        INT FOREIGN KEY REFERENCES TiposUsuario(IdTipoUsuario)
);
GO

CREATE TABLE Pacotes(
IdPacote		INT PRIMARY KEY IDENTITY
,NomePacote		VARCHAR (255) UNIQUE NOT NULL
,Descricao		TEXT NOT NULL
,DataIda		DATE NOT NULL
,DataVolta		DATE NOT NULL
,Valor			DECIMAL (18,2) NOT NULL
,Ativo			BIT DEFAULT (1) NOT NULL
,NomeCidade		VARCHAR (255) NOT NULL
);
GO
```

# 2. Inserir as informações fornecidas pelo cliente (02_Senatur_BD_DML.sql)

```sql
-- Define qual banco de dados será utilizado
USE Senatur_DataBaseFirst;
GO

-- Insere os tipos de usuário
INSERT INTO TiposUsuario(Titulo)
VALUES                  ('Administrador'), ('Cliente');
GO

-- Insere os usuários
INSERT INTO Usuarios(Email, Senha, IdTipoUsuario)
VALUES              ('admin@admin.com','admin',1)
                   ,('cliente@cliente.com','cliente',2);
GO

-- Insere os pacotes
INSERT INTO Pacotes(NomePacote, Descricao, DataIda, DataVolta, Valor, NomeCidade, Ativo)
VALUES             ('SALVADOR - 5 DIAS / 4 DIÁRIAS', 'O que não falta em Salvador são atrações. Prova disso são as praias, os museus e as construções seculares que dão um charme mais que especial à região. A cidade, sinônimo de alegria, também é conhecida pela efervescência cultural que a credenciou como um dos destinos mais procurados por turistas brasileiros e estrangeiros. O Pelourinho e o Elevador são alguns dos principais pontos de visitação.', '2020-08-06', '2020-08-10', '854.00', 'Salvador', 1)
                  ,('RESORTS NA BAHIA - LITORAL NORTE - 5 DIAS / 4 DIÁRIAS', 'O Litoral Norte da Bahia conta com inúmeras praias emolduradas por coqueiros, além de piscinas naturais de águas mornas que são protegidas por recifes e habitadas por peixes coloridos. Banhos de mar em águas calmas ou agitadas, mergulho com snorkel, caminhada pela orla e calçadões, passeios de bicicleta, pontos turísticos históricos, interação com animais e até baladas estão entre as atrações da região. Destacam-se as praias de Guarajuba, Imbassaí, Praia do Forte e Costa do Sauipe.', '2020-05-14', '2020-05-18', '1826.00', 'Salvador', 1)
                  ,('BONITO VIA CAMPO GRANDE - 1 PASSEIO - 5 DIAS / 4 DIÁRIAS', 'Localizado no estado de Mato Grosso do Sul e ao sul do Pantanal, Bonito possui centenas de cachoeiras, rios e lagos de águas cristalinas, além de cavernas inundadas, paredões rochosos e uma infinidade de peixes. Os aventureiros costumam render-se facilmente a esse destino regado por trilhas ecológicas, passeios de bote e descidas de rapel pelas inúmeras quedas d''água da região', '2020-03-28', '2020-04-01', '1004.00', 'Bonito', 1);
GO
```

# 3. Definir as querys referentes aos Endpoints (03_Senatur_BD_DQL.sql)

```sql
-- Define qual banco de dados será utilizado
USE Senatur_DataBaseFirst;
GO

-- Listar todos os usuários
SELECT U.IdUsuario, U.Email, U.IdTipoUsuario, TU.Titulo FROM Usuarios U
INNER JOIN TiposUsuario TU
ON U.IdTipoUsuario = TU.IdTipoUsuario;
GO

-- Buscar um usuário por e-mail e senha
SELECT U.IdUsuario, U.Email, U.IdTipoUsuario, TU.Titulo FROM Usuarios U
INNER JOIN TiposUsuario TU
ON U.IdTipoUsuario = TU.IdTipoUsuario
WHERE U.Email = 'admin@admin.com' AND U.Senha = 'admin';
GO

-- Listar todos os pacotes
SELECT P.NomePacote, P.Descricao, P.DataIda, P.DataVolta, P.Valor, P.NomeCidade, P.Ativo FROM Pacotes P;
GO

-- Buscar um pacote pelo ID
SELECT P.NomePacote, P.Descricao, P.DataIda, P.DataVolta, P.Valor, P.NomeCidade, P.Ativo FROM Pacotes P
WHERE P.IdPacote = 1;
GO

-- Listar somente os pacotes ativos
SELECT P.NomePacote, P.Descricao, P.DataIda, P.DataVolta, P.Valor, P.NomeCidade, P.Ativo FROM Pacotes P
WHERE P.Ativo = 1;
GO

-- Listar somente os pacotes inativos
SELECT P.NomePacote, P.Descricao, P.DataIda, P.DataVolta, P.Valor, P.NomeCidade, P.Ativo FROM Pacotes P
WHERE P.IdPacote = 0;
GO

-- Listar somente os pacotes para uma determinada cidade
SELECT P.NomePacote, P.Descricao, P.DataIda, P.DataVolta, P.Valor, P.NomeCidade, P.Ativo FROM Pacotes P
WHERE P.NomeCidade = 'Salvador';
GO

-- Listar os pacotes com ordenação por preço
SELECT P.NomePacote, P.Descricao, P.DataIda, P.DataVolta, P.Valor, P.NomeCidade, P.Ativo FROM Pacotes P
ORDER BY P.Valor ASC;
GO
```

# 4. Exportar o diagrama do banco de dados gerado

### Expandir o banco de dados

### Clicar com o botão direito do mouse na pasta ```Diagramas de Banco de Dados```

### Escolher a opção ```Novo Diagrama de Banco de Dados```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_exportar_diagrama.png" />

### Selecionar todas as tabelas e adicionar

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_exportar_diagrama_02.png" />

### Salvar o diagrama gerado como imagem (.png, .jpeg etc)

# 5. Criar a solução da API do projeto

### Abrir o Visual Studio e navegar pelo menu ```Arquivo > Novo > Projeto```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao.png" />

### Escolher a opção ```Aplicativo Web ASP.NET Core``` e definir o nome e a pasta destino do projeto

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_02.png" />

### Na tela seguinte, escolher a opção ```Vazio``` e ```desabilitar a configuração HTTPS```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_03.png" />

# 6. Instalar as dependências do projeto

### No Visual Studio, navegar pelo menu ```Projeto > Gerenciar Pacotes do NuGet```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_04.png" />

### Procurar e instalar com as versões definidas

- Microsoft.EntityFrameworkCore.Design (2.1.14)
- Microsoft.EntityFrameworkCore.Tools (2.1.14)
- Microsoft.EntityFrameworkCore.SqlServer (2.1.14)

# 7. Executar o comando Scaffold para gerar os domínios e o contexto através do banco de dados existente

### No Visual Studio, navegar pelo menu ```Ferramentas > Gerenciador de Pacotes do NuGet > Console do Gerenciador de Pacotes```

### No console, executar o comando:

```c#
Scaffold-DbContext "Data Source=Seu-Servidor; Initial Catalog=Senatur_DataBaseFirst; user Id=sa; pwd=sa@132;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Domains -ContextDir Contexts -Context SenaturContext
```

### Assim, o contexto e os domínios serão gerados automagicamente

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_05.png" />

# 8. Definir DataAnnotations nos domínios

### TiposUsuario

```c#
/// <summary>
/// Classe responsável pela entidade TiposUsuario
/// </summary>
public partial class TiposUsuario
{
    public TiposUsuario()
    {
        Usuarios = new HashSet<Usuarios>();
    }

    public int IdTipoUsuario { get; set; }

    // Define que a propriedade é obrigatória
    [Required(ErrorMessage = "O título do tipo de usuário é obrigatório!")]
    public string Titulo { get; set; }

    public ICollection<Usuarios> Usuarios { get; set; }
}
```

### Usuarios

```c#
/// <summary>
/// Classe responsável pela entidade Usuarios
/// </summary>
public partial class Usuarios
{
    public int IdUsuario { get; set; }

    // Define que a propriedade é obrigatória
    [Required(ErrorMessage = "O e-mail do usuário é obrigatório!")]
    // Define o tipo do dado
    [DataType(DataType.EmailAddress)]
    public string Email { get; set; }

    // Define que a propriedade é obrigatória
    [Required(ErrorMessage = "A senha do usuário é obrigatório!")]
    // Define o tipo do dado
    [DataType(DataType.Password)]
    // Define as características da senha
    [StringLength(50, MinimumLength = 5, ErrorMessage = "A senha precisa ter entre 5 e 50 caracteres!")]
    public string Senha { get; set; }

    public int? IdTipoUsuario { get; set; }

    public TiposUsuario IdTipoUsuarioNavigation { get; set; }
}
```

### Pacotes

```c#
/// <summary>
/// Classe responsável pela entidade Pacotes
/// </summary>
public partial class Pacotes
{
    public int IdPacote { get; set; }

    [Required(ErrorMessage = "O nome do pacote é obrigatório!")]
    public string NomePacote { get; set; }

    [Required(ErrorMessage = "A descrição do pacote é obrigatória!")]
    public string Descricao { get; set; }

    [Required(ErrorMessage = "A data de ida do pacote é obrigatória!")]
    [DataType(DataType.Date)]
    public DateTime DataIda { get; set; }

    [Required(ErrorMessage = "A data de volta do pacote é obrigatória!")]
    [DataType(DataType.Date)]
    public DateTime DataVolta { get; set; }

    [Required(ErrorMessage = "O preço do pacote é obrigatório!")]
    public decimal Valor { get; set; }

    public bool? Ativo { get; set; }

    [Required(ErrorMessage = "O nome da cidade do pacote é obrigatório!")]
    public string NomeCidade { get; set; }
}
```

# 9. Definir as ViewModels do projeto

### Clicar com o botão direito do mouse sobre o projeto e adicionar uma nova pasta com o nome ```ViewModels```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_06.png" />

## ViewModel de Login

### Clicar com o botão direito do mouse sobre a pasta ```ViewModels``` e clicar na opção ```Adicionar > Classe```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_07.png" />

### Escolher o tipo ```Classe``` e nomear como ```LoginViewModel```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_08.png" />

### Definir as propriedades da classe

```c#
/// <summary>
/// Classe responsável pelo modelo de Login
/// </summary>
public class LoginViewModel
{
    // Define que a propriedade é obrigatória
    [Required(ErrorMessage = "Informe o e-mail do usuário!")]
    // Define que o tipo de dado
    [DataType(DataType.EmailAddress)]
    public string Email { get; set; }

    // Define que a propriedade é obrigatória
    [Required(ErrorMessage = "Informe a senha do usuário!")]
    // Define que o tipo de dado
    [DataType(DataType.Password)]
    public string Senha { get; set; }
}
```

# 10. Definir as interfaces do projeto

### Clicar com o botão direito do mouse sobre o projeto e adicionar uma nova pasta com o nome ```Interfaces```

## Interface dos tipos de usuário

### Clicar com o botão direito do mouse sobre a pasta ```Interfaces``` e clicar na opção ```Adicionar > Classe```

### Escolher o tipo ```Interface``` e nomear como ```ITipoUsuarioRepository```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_09.png" />

### Definir os métodos referentes aos tipos de usuário

```c#
/// <summary>
/// Interface responsável pelo TipoUsuarioRepository
/// </summary>
interface ITipoUsuarioRepository
{
    /// <summary>
    /// Lista todos os tipos de usuário
    /// </summary>
    /// <returns>Uma lista de tipos de usuário</returns>
    List<TiposUsuario> ListarTiposUsuario();
}
```

<strong>Obs.: não esquecer de definir o uso do namespace dos domínios</strong>
  
  ```c#
  using Senatur.WebApi.DataBaseFirst.Domains;
  ```

## Interface dos usuários

### Repetir o processo para adicionar a classe ```IUsuarioRepository```

### Definir os métodos referentes aos usuários

```c#
/// <summary>
/// Interface responsável pelo UsuarioRepository
/// </summary>
interface IUsuarioRepository
{
    /// <summary>
    /// Lista todos os usuários
    /// </summary>
    /// <returns>Uma lista de usuários</returns>
    List<Usuarios> ListarUsuarios();

    /// <summary>
    /// Valida um usuário
    /// </summary>
    /// <param name="email">E-mail do usuário</param>
    /// <param name="senha">Senha do usuário</param>
    /// <returns>Um usuário autenticado</returns>
    Usuarios BuscarPorEmailSenha(string email, string senha);
}
```

## Interface dos pacotes

### Repetir o processo para adicionar a classe ```IPacoteRepository```

### Definir os métodos referentes aos pacotes

```c#
/// <summary>
/// Interface responsável pelo PacoteRepository
/// </summary>
interface IPacoteRepository
{
    /// <summary>
    /// Lista todos os pacotes
    /// </summary>
    /// <returns>Uma lista de pacotes</returns>
    List<Pacotes> ListarPacotes();

    /// <summary>
    /// Busca um pacote através do ID
    /// </summary>
    /// <param name="id">ID do pacote que será buscado</param>
    /// <returns>Um pacote buscado</returns>
    Pacotes BuscarPacotePorId(int id);

    /// <summary>
    /// Cadastra um novo pacote
    /// </summary>
    /// <param name="novoPacote">Objeto com as informações que serão cadastradas</param>
    void CadastrarPacote(Pacotes novoPacote);

    /// <summary>
    /// Atualiza um pacote existente
    /// </summary>
    /// <param name="id">ID do pacote que será atualizado</param>
    /// <param name="pacoteAtualizado">Objeto com as novas informações do pacote</param>
    void AtualizarPacote(int id, Pacotes pacoteAtualizado);
    
    /// <summary>
    /// Lista apenas os pacotes ativos ou inativos
    /// </summary>
    /// <param name="ativo">Parâmetro para definir se a lista será de ativos ou inativos</param>
    /// <returns>Uma lista de pacotes ativos ou uma lista de pacotes inativos</returns>
    List<Pacotes> ListarPacotesAtivosInativos(bool ativo);

    /// <summary>
    /// Lista todos os pacotes para uma cidade
    /// </summary>
    /// <param name="cidade">Nome da cidade destino dos pacotes</param>
    /// <returns>Uma lista de pacotes para uma determinada cidade</returns>
    List<Pacotes> ListarPacotesCidade(string cidade);

    /// <summary>
    /// Lista todos os pacotes com ordenação por preço
    /// </summary>
    /// <param name="preco">Parâmetro para definir se a lista será crescente ou descrescente pelo preço</param>
    /// <returns>Uma lista de pacotes ordenada pelo preço</returns>
    List<Pacotes> ListarPacotesPorPreco(string preco);
}
```

# 11. Definir os repositórios do projeto

### Clicar com o botão direito do mouse sobre o projeto e adicionar uma nova pasta com o nome ```Repositories```

## Repositório dos tipos de usuário

### Clicar com o botão direito do mouse sobre a pasta ```Repositories``` e clicar na opção ```Adicionar > Classe```

### Escolher o tipo ```Classe``` e nomear como ```TipoUsuarioRepository```

### Implementar os métodos referentes aos tipos de usuário

<strong>Não esquecer de: 
  - herdar a classe da interface responsável
  - definir o uso do namespace
  - instanciar um contexto para chamada dos métodos do EF Core
</strong>

```c#
/// <summary>
/// Classe responsável pelo repositório dos tipos de usuário
/// </summary>
public class TipoUsuarioRepository : ITipoUsuarioRepository
{
    /// <summary>
    /// Instancia um contexto para chamada dos métodos do EF Core
    /// </summary>
    SenaturContext ctx = new SenaturContext();

    public List<TiposUsuario> ListarTiposUsuario()
    {
        // Lista todos os tipos de usuário
        return ctx.TiposUsuario.ToList();
    }
}
```

## Repositório dos usuários

### Clicar com o botão direito do mouse sobre a pasta ```Repositories``` e clicar na opção ```Adicionar > Classe```

### Escolher o tipo ```Classe``` e nomear como ```UsuarioRepository```

### Implementar os métodos referentes aos usuários

```c#
/// <summary>
/// Classe responsável pelo repositório dos usuários
/// </summary>
public class UsuarioRepository : IUsuarioRepository
{
    /// <summary>
    /// Instancia um contexto para chamada dos métodos do EF Core
    /// </summary>
    SenaturContext ctx = new SenaturContext();

    /// <summary>
    /// Valida um usuário
    /// </summary>
    /// <param name="email">E-mail do usuário</param>
    /// <param name="senha">Senha do usuário</param>
    /// <returns>Um usuário autenticado</returns>
    public Usuarios BuscarPorEmailSenha(string email, string senha)
    {
        // Busca um usuário através do e-mail e senha informados
        Usuarios usuarioBuscado = ctx.Usuarios.FirstOrDefault(u => u.Email == email && u.Senha == senha);

        // Verifica se nenhum usuário foi encontrado
        if (usuarioBuscado == null)
        {
            // Retorna nulo
            return null;
        }

        // Retorna o usuário encontrado
        return usuarioBuscado;
    }

    /// <summary>
    /// Lista todos os usuários
    /// </summary>
    /// <returns>Uma lista de usuários</returns>
    public List<Usuarios> ListarUsuarios()
    {
        // Lista todos os usuários com as informações do tipo de usuário
        return ctx.Usuarios.Include(u => u.IdTipoUsuarioNavigation).ToList();
    }
}
```

## Repositório dos pacotes

### Clicar com o botão direito do mouse sobre a pasta ```Repositories``` e clicar na opção ```Adicionar > Classe```

### Escolher o tipo ```Classe``` e nomear como ```PacoteRepository```

### Implementar os métodos referentes aos pacotes

```c#
/// <summary>
/// Classe responsável pelo repositório dos pacotes
/// </summary>
public class PacoteRepository : IPacoteRepository
{
    /// <summary>
    /// Instancia um contexto para chamada dos métodos do EF Core
    /// </summary>
    SenaturContext ctx = new SenaturContext();

    /// <summary>
    /// Atualiza um pacote existente
    /// </summary>
    /// <param name="id">ID do pacote que será atualizado</param>
    /// <param name="pacoteAtualizado">Objeto com as novas informações do pacote</param>
    public void AtualizarPacote(int id, Pacotes pacoteAtualizado)
    {
        // Busca um pacote através do ID informado
        Pacotes pacoteBuscado = BuscarPacotePorId(id);

        // Verifica se algum pacote foi encontrado
        if (pacoteBuscado != null)
        {
            // Atualiza o objeto buscado com as novas informações
            pacoteBuscado = pacoteAtualizado;

            // Atualiza o pacote buscado para enviar para o banco de dados
            ctx.Pacotes.Update(pacoteBuscado);

            // Salva as informações no banco de dados
            ctx.SaveChanges();
        }
    }

    /// <summary>
    /// Busca um pacote através do ID
    /// </summary>
    /// <param name="id">ID do pacote que será buscado</param>
    /// <returns>Um pacote buscado</returns>
    public Pacotes BuscarPacotePorId(int id)
    {
        // Busca um pacote através do ID informado
        return ctx.Pacotes.Find(id);
    }

    /// <summary>
    /// Cadastra um novo pacote
    /// </summary>
    /// <param name="novoPacote">Objeto com as informações do pacote que será cadastrado</param>
    public void CadastrarPacote(Pacotes novoPacote)
    {
        // Adiciona um novo objeto que será cadastrado
        ctx.Pacotes.Add(novoPacote);

        // Salva as informações no banco de dados
        ctx.SaveChanges();
    }

    /// <summary>
    /// Lista todos os pacotes
    /// </summary>
    /// <returns>Uma lista de pacotes</returns>
    public List<Pacotes> ListarPacotes()
    {
        // Lista todos os pacotes
        return ctx.Pacotes.ToList();
    }

    /// <summary>
    /// Lista todos os pacotes ativos ou todos os pacotes inativos
    /// </summary>
    /// <param name="ativo">Parâmetro que irá definir se será uma lista de pacotes ativos ou inativos</param>
    /// <returns>Uma lista de pacotes ativos ou uma lista de pacotes inativos</returns>
    public List<Pacotes> ListarPacotesAtivosInativos(bool ativo)
    {
        // Verifica qual o parâmetro informado para listar
        if (ativo == true || ativo == false)
        {
            // Retorna uma lista de pacotes utilizando o parâmetro informado
            return ctx.Pacotes.ToList().FindAll(p => p.Ativo == ativo);
        }

        // Caso o parâmetro não atenda às condições, retorna nulo
        return null;
    }

    /// <summary>
    /// Lista todos os pacotes de uma determinada cidade como destino
    /// </summary>
    /// <param name="cidade">Cidade destino dos pacotes</param>
    /// <returns>Uma lista de pacotes de uma determinada cidade como destino</returns>
    public List<Pacotes> ListarPacotesCidade(string cidade)
    {
        // Lista todos os pacotes de uma determinada cidade
        return ctx.Pacotes.Where(p => p.NomeCidade.Contains(cidade)).ToList();
    }

    /// <summary>
    /// Lista todos os pacotes de forma ordenada por preço
    /// </summary>
    /// <param name="preco">Parâmetro que irá definir se a lista será crescente ou decrescente</param>
    /// <returns>Uma lista de pacotes ordenada por preço</returns>
    public List<Pacotes> ListarPacotesPorPreco(string preco)
    {
        // Verifica o parâmetro informado
        if (preco.ToLower() == "asc")
        {
            // Retorna a lista de pacotes ordenada por preços crescentes
            return ctx.Pacotes.OrderBy(p => p.Valor).ToList();
        }

        // Verifica o parâmetro informado
        if (preco.ToLower() == "desc")
        {
            // Retorna a lista de pacotes ordenada por preços decrescentes
            return ctx.Pacotes.OrderByDescending(p => p.Valor).ToList();
        }

        // Caso o parâmetro não atenda às condições, retorna nulo
        return null;
    }
}
```

# 12. Definir os controllers do projeto

### Clicar com o botão direito do mouse sobre o projeto e adicionar uma nova pasta com o nome ```Controllers```

## Controller dos tipos de usuário

### Clicar com o botão direito do mouse sobre a pasta ```Controllers``` e clicar na opção ```Adicionar > Controlador```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_10.png" />

### Escolher o tipo ```Controlador API - Vazio``` e nomear como ```TiposUsuarioController```

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_11.png" />

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_12.png" />

### Definir as configurações e os endpoints do controlador

```c#
/// <summary>
/// Controller responsável pelos endpoints referentes aos tipos de usuário
/// </summary>

// Define que o tipo de resposta da API será no formato JSON
[Produces("application/json")]

// Define que a rota de uma requisição será no formato domínio/api/NomeController
[Route("api/[controller]")]

// Define que é um controlador de API
[ApiController]
public class TiposUsuarioController : ControllerBase
{
    /// <summary>
    /// Cria um objeto _tipoUsuarioRepository que irá receber todos os métodos definidos na interface
    /// </summary>
    private ITipoUsuarioRepository _tipoUsuarioRepository;

    /// <summary>
    /// Instancia este objeto para que haja a referência aos métodos no repositório
    /// </summary>
    public TiposUsuarioController()
    {
        _tipoUsuarioRepository = new TipoUsuarioRepository();
    }

    /// <summary>
    /// Lista todos os tipos de usuário
    /// </summary>
    /// <returns>Uma lista de tipos de usuário e um status code 200 - Ok</returns>
    [HttpGet]
    public IActionResult Get()
    {
        // Retora a resposta da requisição fazendo a chamada para o método
        return Ok(_tipoUsuarioRepository.ListarTiposUsuario());
    }
}
```

## Controller dos usuários

### Clicar com o botão direito do mouse sobre a pasta ```Controllers``` e clicar na opção ```Adicionar > Controlador```

### Escolher o tipo ```Controlador API - Vazio``` e nomear como ```UsuariosController```

### Definir as configurações e os endpoints do controlador

```c#
/// <summary>
/// Controller responsável pelos endpoints referentes aos usuários
/// </summary>

// Define que o tipo de resposta da API será no formato JSON
[Produces("application/json")]

// Define que a rota de uma requisição será no formato domínio/api/NomeController
[Route("api/[controller]")]

// Define que é um controlador de API
[ApiController]
public class UsuariosController : ControllerBase
{
    /// <summary>
    /// Cria um objeto _usuarioRepository que irá receber todos os métodos definidos na interface
    /// </summary>
    private IUsuarioRepository _usuarioRepository;

    /// <summary>
    /// Instancia este objeto para que haja a referência aos métodos no repositório
    /// </summary>
    public UsuariosController()
    {
        _usuarioRepository = new UsuarioRepository();
    }

    /// <summary>
    /// Lista todos os usuários
    /// </summary>
    /// <returns>Uma lista de usuários e um status code 200 - Ok</returns>
    [HttpGet]
    public IActionResult Get()
    {
        // Retora a resposta da requisição fazendo a chamada para o método
        return Ok(_usuarioRepository.ListarUsuarios());
    }
}
```

## Controller dos pacotes

### Clicar com o botão direito do mouse sobre a pasta ```Controllers``` e clicar na opção ```Adicionar > Controlador```

### Escolher o tipo ```Controlador API - Vazio``` e nomear como ```PacotesController```

### Definir as configurações e os endpoints do controlador

```c#
/// <summary>
/// Controller responsável pelos endpoints referentes aos pacotes
/// </summary>

// Define que o tipo de resposta da API será no formato JSON
[Produces("application/json")]

// Define que a rota de uma requisição será no formato domínio/api/NomeController
[Route("api/[controller]")]

// Define que é um controlador de API
[ApiController]
public class PacotesController : ControllerBase
{
    /// <summary>
    /// Cria um objeto _usuarioRepository que irá receber todos os métodos definidos na interface
    /// </summary>
    private IPacoteRepository _pacoteRepository;

    /// <summary>
    /// Instancia este objeto para que haja a referência aos métodos no repositório
    /// </summary>
    public PacotesController()
    {
        _pacoteRepository = new PacoteRepository();
    }

    /// <summary>
    /// Lista todos os pacotes
    /// </summary>
    /// <returns>Uma lista de pacotes e um status code 200 - Ok</returns>
    [HttpGet]
    public IActionResult Get()
    {
        // Retora a resposta da requisição fazendo a chamada para o método
        return Ok(_pacoteRepository.ListarPacotes());
    }

    /// <summary>
    /// Busca um pacote através do ID
    /// </summary>
    /// <param name="id">ID do pacote que será buscado</param>
    /// <returns>Um pacote buscado e um status code 200 - Ok</returns>
    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        // Retora a resposta da requisição fazendo a chamada para o método
        return Ok(_pacoteRepository.BuscarPacotePorId(id));
    }

    /// <summary>
    /// Cadastra um novo pacote
    /// </summary>
    /// <param name="novoPacote">Objeto com as informações</param>
    /// <returns>Um status code 201 - Created</returns>
    [HttpPost]
    public IActionResult Post(Pacotes novoPacote)
    {
        // Faz a chamada para o método
        _pacoteRepository.CadastrarPacote(novoPacote);

        // Retorna um status code
        return StatusCode(201);
    }

    /// <summary>
    /// Atualiza um pacote existente
    /// </summary>
    /// <param name="id">ID do pacote que será atualizado</param>
    /// <param name="pacoteAtualizado">Objeto com as novas informações</param>
    /// <returns>Um status code 204 - No Content</returns>
    [HttpPatch("{id}")]
    public IActionResult Put(int id, Pacotes pacoteAtualizado)
    {
        // Faz a chamada para o método
        _pacoteRepository.AtualizarPacote(id, pacoteAtualizado);

        // Retorna um status code
        return StatusCode(204);
    }
}
```

# 13. Configurar a ```Startup.cs``` para executar o projeto

### Adicionar os serviços MVC e a versão compatível

```c#
// This method gets called by the runtime. Use this method to add services to the container.
// For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
public void ConfigureServices(IServiceCollection services)
{
    services
        // Adiciona MVC ao projeto
        .AddMvc()

        // Define a versão compatível do .NET Core
        .SetCompatibilityVersion(Microsoft.AspNetCore.Mvc.CompatibilityVersion.Version_2_1);
}
```

### Definir o uso do serviço

```c#
// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
public void Configure(IApplicationBuilder app, IHostingEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }

    // Define o uso do MVC
    app.UseMvc();
}
```

### Executar o projeto e testar as requisições

<img src="https://github.com/carolline-alves-barros/senai-dev-1s2020/blob/master/sprint-2-backend/03_efcore/02.senatur/roteiro/databaseFirst/imagens/Senatur_criar_solucao_13.png" />






