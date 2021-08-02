# iMovies

Este é um aplicativo de estudos que trás uma listagem de filmes contendo algumas informações para que você possa ficar por dentro do que está rolando no mundo do cinema.

<img src="https://user-images.githubusercontent.com/11183888/127782453-b4505dcd-9091-45fd-bea9-f5fdd90f3425.png" width="400"/> <img src="https://user-images.githubusercontent.com/11183888/127782450-b3f7554b-941d-4f36-9b01-268cd6b41806.png" width="400"/>

### Arquitetura utilizada

Para esse desenvolvimento foi utilizada a arquitetura MVVM-C, seguindo a ideia abaixo:

<img src="https://user-images.githubusercontent.com/11183888/127782285-d0c58447-b778-4516-a758-dcd39cc8d4bc.png" width="600"/>

- Todo o desenvolvimento foi guiado com o uso de protocolos para deixar as camadas mais desacopladas e facilitar a implementação de testes unitários;
- Foi utilizado o pattern de Factory para montagem de cada uma das cenas fazendo a injeção de dependências.

### API 

- A API utilizada para a busca de filmes foi a [TheMovieDB 🍿](https://developers.themoviedb.org/3)

### Camada de Network

Foi utilizado uma abordagem simples para a realização de chamadas para a Api, focando em código nativos e não utilização de nenhuma biblioteca.

### Pods

Para auxílio do desenvolvimento, os seguintes pods foram utilizados:

- [Kingfisher](https://github.com/onevcat/Kingfisher) 
-- Bliblioteca utilizada para baixar imagens de maneira assíncrona.
- [Lottie](https://github.com/airbnb/lottie-ios)
-- Biblioteca utilizada para fazer animações

### Testes unitários

Feito testes unitários utilizando XCTests, com foco na camada de ViewModel e Service.

### Próximos passos

Como próximos passos para esse app estão listado os seguintes itens:
- Implementação de filtro de categoria para listagem de filmes;
- Implementação de filtro por idioma;
- Implementação de internacionalização das strings;
- Melhoria de design da tela (corrigir quebra de constraints na tela inicial).
