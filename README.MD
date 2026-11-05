#  SafeRoute — Navegação Inteligente e Colaborativa

> Aplicativo de navegação que busca melhorar a mobilidade urbana por meio da identificação colaborativa de alagamentos, enchentes, obras e interdições, oferecendo rotas alternativas aos motoristas.

##  1. Sobre o Projeto

O **SafeRoute** é uma proposta de aplicativo de navegação para Android e iOS, inspirado em plataformas como Waze e Google Maps, mas com foco especial na identificação de problemas nas vias públicas.

A aplicação permitirá que motoristas compartilhem informações sobre alagamentos, enchentes, obras e interdições, ajudando outros usuários a evitar trechos comprometidos durante seus deslocamentos.

Inicialmente, o projeto terá como região de atuação os municípios de:

- Americana – SP;
- Santa Bárbara d'Oeste – SP;
- Nova Odessa – SP;
- Sumaré – SP.

## 2. Identificação do Problema

Motoristas frequentemente enfrentam dificuldades durante seus deslocamentos devido a situações inesperadas, como:

- Ruas e avenidas alagadas;
- Enchentes causadas por chuvas intensas;
- Obras e reformas nas vias públicas;
- Ruas temporariamente interditadas;
- Falta de informações atualizadas sobre as condições das vias.

Muitas vezes, os motoristas descobrem esses problemas somente quando chegam ao local, ocasionando atrasos, congestionamentos e situações de risco.

**Problema identificado:** a dificuldade de encontrar rotas alternativas diante de alagamentos, enchentes e interdições, especialmente em regiões onde essas ocorrências são frequentes.

##  3. Justificativa

O desenvolvimento do SafeRoute justifica-se pela necessidade de melhorar a mobilidade urbana e proporcionar maior segurança aos motoristas.

A proposta utiliza a colaboração entre usuários para compartilhar informações sobre as condições das vias, permitindo que outros motoristas sejam alertados antes de chegar a determinados locais.

Com essas informações, o aplicativo poderá identificar trechos comprometidos e oferecer caminhos alternativos, contribuindo para deslocamentos mais seguros e eficientes.

##  4. Objetivos

### Objetivo Geral

Desenvolver um aplicativo de navegação colaborativa capaz de identificar problemas nas vias e oferecer rotas alternativas para evitar regiões com alagamentos, enchentes e obras.

### Objetivos Específicos

- Facilitar a localização de destinos;
- Identificar vias com problemas de circulação;
- Permitir que motoristas compartilhem ocorrências;
- Disponibilizar informações atualizadas sobre as condições das vias;
- Calcular rotas alternativas;
- Melhorar a experiência e a segurança dos deslocamentos.

##  5. Público-Alvo

O aplicativo será destinado principalmente a:

- Motoristas de automóveis;
- Motociclistas;
- Trabalhadores que utilizam veículos diariamente;
- Pessoas que circulam frequentemente pelas cidades atendidas.

##  6. Pesquisa Regional

O levantamento inicial identificou regiões que apresentam registros ou relatos de problemas relacionados a alagamentos e enchentes.

### Americana

- Avenida Bandeirantes;
- Rua Carioba;
- Rua Bahia;
- Rua Diogo de Faria;
- Região da Avenida Paschoal Ardito.

### Santa Bárbara d'Oeste

- Jardim Conceição;
- Vila Sartori;
- Jardim Vista Alegre;
- Jardim Icaraí;
- Região da ponte Roldão Jorge Ferreira.

### Nova Odessa

- Regiões próximas ao Ribeirão Quilombo;
- Passagens inferiores de córregos;
- Áreas monitoradas pela Defesa Civil.

### Sumaré

- Região da Vila Diva;
- Áreas próximas ao Ribeirão Quilombo.

**Observação:** os locais representam um levantamento preliminar. A confirmação dos pontos, trechos e coordenadas deverá ocorrer durante a pesquisa. O cadastro operacional do aplicativo será alimentado exclusivamente pelos usuários.

##  7. Pesquisa de Concorrentes

Foram considerados aplicativos de navegação já utilizados no mercado.

| Aplicativo  | Características                                   |
| ----------- | ------------------------------------------------- |
| Waze        | Navegação, trânsito e alertas colaborativos.      |
| Google Maps | Mapas, pesquisa de destinos e rotas alternativas. |
| Apple Maps  | Navegação e informações de trânsito.              |

### Diferencial do SafeRoute

O SafeRoute pretende priorizar ocorrências relacionadas a alagamentos, enchentes e obras, oferecendo um sistema de identificação, confirmação e validade dos relatos, integrado ao cálculo de rotas alternativas.

O objetivo não é reproduzir todas as funcionalidades dos concorrentes, mas oferecer uma experiência direcionada à prevenção de problemas durante os deslocamentos.

##  8. Funcionamento da Aplicação

O funcionamento principal será dividido em quatro etapas:

1. **Identificação:** um motorista encontra uma rua alagada, uma enchente ou uma obra.
2. **Registro:** o usuário informa a ocorrência diretamente pelo aplicativo.
3. **Compartilhamento:** a informação aparece no mapa e pode ser confirmada por outros motoristas.
4. **Redirecionamento:** o sistema considera o trecho comprometido e procura uma rota alternativa.

As ocorrências deverão conter localização, categoria, horário e prazo de validade, evitando que informações antigas continuem interferindo nas rotas.

##  9. Funcionalidades do Sistema

### Requisitos Funcionais

| Código | Descrição                                           |
| ------ | --------------------------------------------------- |
| RF01   | Permitir cadastro de usuários.                      |
| RF02   | Permitir login e logout.                            |
| RF03   | Exibir mapa com localização atual.                  |
| RF04   | Permitir pesquisa de endereços e destinos.          |
| RF05   | Calcular rotas entre origem e destino.              |
| RF06   | Exibir rotas alternativas.                          |
| RF07   | Permitir iniciar e encerrar navegação.              |
| RF08   | Identificar pontos de alagamento.                   |
| RF09   | Identificar regiões com enchentes.                  |
| RF10   | Identificar obras e interdições.                    |
| RF11   | Permitir registrar ocorrências.                     |
| RF12   | Registrar localização e horário das ocorrências.    |
| RF13   | Permitir confirmar ocorrências.                     |
| RF14   | Permitir informar que uma via foi liberada.         |
| RF15   | Exibir alertas durante a navegação.                 |
| RF16   | Recalcular rotas para evitar trechos comprometidos. |
| RF17   | Exibir distância e tempo estimado.                  |
| RF18   | Expirar ocorrências antigas.                        |
| RF19   | Consultar histórico de ocorrências.                 |
| RF20   | Permitir denunciar informações incorretas.          |

### Requisitos Não Funcionais

| Código | Descrição                                      |
| ------ | ---------------------------------------------- |
| RNF01  | Compatibilidade com Android e iOS.             |
| RNF02  | Interface simples e intuitiva.                 |
| RNF03  | Boa precisão de localização.                   |
| RNF04  | Atualização das informações em tempo adequado. |
| RNF05  | Proteção dos dados pessoais.                   |
| RNF06  | Suporte a múltiplos usuários simultaneamente.  |
| RNF07  | Estabilidade durante a navegação.              |
| RNF08  | Boa legibilidade da interface.                 |
| RNF09  | Tolerância a falhas de conexão.                |
| RNF10  | Segurança na utilização do aplicativo.         |

##  10. Regras de Negócio

- RN01: somente usuários autenticados poderão publicar ocorrências.
- RN02: toda ocorrência deverá possuir categoria e localização.
- RN03: toda ocorrência deverá registrar data e horário.
- RN04: os usuários poderão confirmar ou contestar relatos.
- RN05: ocorrências antigas deverão perder validade automaticamente.
- RN06: ocorrências confirmadas terão maior confiabilidade.
- RN07: trechos bloqueados deverão ser evitados no cálculo de rotas.
- RN08: caso não exista uma rota alternativa segura identificada, o aplicativo deverá informar essa condição.
- RN09: o sistema deverá priorizar a segurança do motorista durante a navegação.
- RN10: a localização deverá ser utilizada conforme as permissões concedidas pelo usuário.

##  11. Tecnologias Propostas

As tecnologias abaixo são sugestões iniciais e poderão ser ajustadas durante o desenvolvimento.

| Tecnologia            | Finalidade                       |
| --------------------- | -------------------------------- |
| Flutter               | Desenvolvimento multiplataforma. |
| Dart                  | Linguagem de programação.        |
| Supabase              | Backend e autenticação.          |
| PostgreSQL            | Banco de dados.                  |
| Mapbox ou Google Maps | Exibição de mapas.               |
| GPS                   | Identificação da localização.    |

##  12. Wireframes e Prototipagem

A primeira versão do protótipo deverá apresentar as seguintes telas:

### 12.1 Tela de Login e Cadastro

- Campo de e-mail;
- Campo de senha;
- Botão de login;
- Opção de criar conta.

### 12.2 Tela Inicial

- Mapa interativo;
- Localização atual;
- Campo de pesquisa de destino;
- Identificação de ocorrências;
- Acesso ao perfil.

### 12.3 Tela de Rotas

- Origem e destino;
- Rota principal;
- Rotas alternativas;
- Distância e tempo estimado;
- Botão para iniciar navegação.

### 12.4 Tela de Ocorrências
 
- Alagamentos;
- Enchentes;
- Obras;
- Interdições;
- Confirmação de ocorrências.

### 12.5 Tela de Registro de Ocorrências

- Seleção do tipo de problema;
- Localização da ocorrência;
- Campo para descrição;
- Opção de enviar o registro.

**Ferramenta sugerida para prototipagem:** Figma.

##  13. Escopo do Projeto

### Primeira Versão (MVP)

- Cadastro e login;
- Mapa e localização;
- Pesquisa de destinos;
- Cálculo de rotas;
- Registro de ocorrências;
- Confirmação de ocorrências;
- Identificação de vias comprometidas;
- Cálculo de rotas alternativas.

### Funcionalidades Futuras

- Integração com Android Auto;
- Integração com Apple CarPlay;
- Comandos por voz;
- Histórico avançado de ocorrências;
- Análise de padrões de alagamentos;
- Expansão para outras regiões.

##  14. Riscos e Desafios

| Desafio              | Possível solução                            |
| -------------------- | ------------------------------------------- |
| Relatos falsos       | Sistema de confirmação e reputação.         |
| Poucos usuários      | Iniciar em uma região limitada.             |
| Ocorrências antigas  | Validade automática dos relatos.            |
| Falta de internet    | Armazenamento temporário quando possível.   |
| Rotas incorretas     | Integração com serviço de roteamento.       |
| Segurança ao dirigir | Alertas por áudio e interface simplificada. |

##  15. Planejamento — Semana 1

**Objetivo:** identificar um problema e definir os requisitos iniciais do projeto.

| Dia   | Atividade                                            | Resultado             |
| ----- | ---------------------------------------------------- | --------------------- |
| Dia 1 | Formação dos grupos e divisão das responsabilidades. | Organização do grupo. |
| Dia 2 | Pesquisa e identificação do problema.                | Problema documentado. |
| Dia 3 | Planejamento e definição de requisitos.              | Requisitos iniciais.  |
| Dia 4 | Desenvolvimento dos wireframes.                      | Protótipo inicial.    |
| Dia 5 | Organização e revisão da documentação.               | Entrega final.        |


##  16. Referências

- Prefeitura de Americana — Plano de Drenagem.
- Prefeitura de Nova Odessa — Informações sobre monitoramento de áreas sujeitas a alagamentos.
- Prefeitura de Santa Bárbara d'Oeste — Informações sobre ocorrências de chuvas.
- Waze — Recursos de alertas e ocorrências colaborativas.
- Google Maps — Recursos de navegação e rotas.
- Apple Maps — Recursos de navegação.

---

##  17. Considerações Finais

O SafeRoute busca desenvolver uma solução tecnológica voltada a um problema real de mobilidade urbana.

Por meio da colaboração entre motoristas, o aplicativo pretende oferecer informações sobre as condições das vias e facilitar a identificação de caminhos alternativos.

Nesta primeira etapa, foram definidos o problema, a proposta de solução, o público-alvo, os requisitos iniciais, as tecnologias propostas e a estrutura das telas.

As próximas etapas do projeto serão destinadas ao aprofundamento dos requisitos, desenvolvimento do protótipo e implementação das funcionalidades.

**SafeRoute — Seu caminho mais seguro começa com a informação.**
