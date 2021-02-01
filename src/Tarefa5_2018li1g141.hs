{-|
Module      : Tarefa6_2018li1g141
Description : Módulo para animar o jogo.
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;

-}
module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap
import Graphics.Gloss.Juicy
import LI11819
import Tarefa0_2018li1g141
import Tarefa1_2018li1g141
import Tarefa2_2018li1g141
--import Tarefa3_2018li1g141 
import Tarefa4_2018li1g141
import Tarefa6_2018li1g141
import Data.List

-- * Introdução 

-- ***O objectivo desta tarefa é implementar o jogo completo usando a biblioteca Gloss.
-- ***Como ponto de partida deve começar por implementar uma versão com uma visualização gráfica simples. Apesar de dever ser construída inicialmente sobre as tarefas anteriores, esta tarefa trata-se no entanto acima de tudo de uma “tarefa aberta”, onde se estimula que se explorem diferentes possibilidades extra para melhorar o aspecto final e jogabilidade do jogo.

-- ***Na criação desta tarefa optamos por implementar as seguintes funcionalidades de forma a melhorar o aspeto do jogo:

-- ***1º --> Gráficos visualmente apelativos: 
-- ***   Ao escolher uma palete de cores e um tema (água) diferente, assim como imagens criadas pelo próprio grupo, pensamos que o resultado final do jogo seja bastante creativo e original.

-- ***2º --> Menus de início e fim do jogo:
-- ***   Começamos com um menu inicial, um menu onde se escolhe o número de jogadores, seguido de um menu onde se escolhe um mapa, seguido do jogo concreto e de uma mensagem de vitória no final deste e onde é dada a possibilidade de voltar a jogar ou voltar ao menu, e ainda um menu de pausa.

-- ***3º --> Mostrar informação sobre o estado do jogo:
-- ***   Ao implementar paineis laterais com informação acerca das vidas, lasers e choques restantes de cada jogador, o jogo torna-se, desta forma, mais fluido e interativo.

-- ***4º --> Mostrar o tempo:
-- ***   Temporizador que inicia no inicio do jogo e para quando resta um jogador, ou seja, o vencedor.

-- ***5º --> Permitir jogar diferentes mapas e/ou carregar mapas definidos pelo utilizador:
-- ***   O jogador tem a possibilidade de escolher entre três mapas.  

-- ***6º --> Permitir jogar contra outros jogadores:
-- ***   Podem jogar até quatro pessoas ao mesmo tempo.



-- * Objetivos desta tarefa

-- *** No cerne desta tarefa estão as funções da Tarefa 2 (jogada), que permite aos jogadores efetuarem jogadas, e da Tarefa 4 (tick), que faz evoluir o jogo ao longo do tempo.       
-- *** De forma a facilitar a realização da tarefa e das diferentes funções necessárias optamos por separar os tipos, sendo que os principais sao o EstadoGloss e o tipo Tudo.
-- *** O EstadoGloss contem o Estado definido no módulo LI11819 assim como informação adicional relevante para a execução do jogo, nomeadamente as Picture's necessárias aos menus. O tipo Tudo contem maioritariamente as Pictures necessárias a realização do jogo, estando essas Picture's agrupadas em diferentes 'subtipos'.
-- *** Por exemplo, o EstadoMapa, o EstadoDisparos e o EstadoJogadores foram utilizados para criar algumas das funcões principais necessárias para converter um Estado numa Picture.


-- *** Podemos dividir esta tarefa em três partes essenciais:

-- ***1º --> A primeira parte, e mais importante, a parte gráfica do jogo propriamente dito, isto é, a visualização das Tarefas anteriores. Para isso tivemos de definir uma função que convertesse um Estado numa Picture, o que inclui as conversões Mapa->Picture, Jogador -> Picture, Disparo -> Picture; uma função que reage a pressionar as teclas, isto é, a introdução de controlos no jogo, e uma função que reage ao tempo.
-- ***2º --> A segunda parte, criação de paineis laterais com informação sobre o estado de jogo, isto é, onde aparece o número de vidas, lasers e choques restantes de cada jogador. Esta parte é intensamente envolvida de Picture's
-- ***3º --> A terceira parte, criação de menus.


-- * Nota

-- **Optamos por adicionar quatro bools que correspondem aos diferentes menus:

-- ***1º --> (True,False,False,False,False) - Menu inicial
-- ***2º --> (False,True,False,False,False) - Menu de escolha do número de jogadores
-- ***3º --> (False,False,True,False,False) - Menu onde se escolhe os mapas
-- ***4º --> (False,False,False,True,False) - Menu onde corre o jogo propriamente dito 
-- ***5º --> (False,False,False,False,True) - Menu de pausa no jogo

type EstadoGloss = (Menus,Menu1,Menu2,Menu3,Pause,Estado,Int)
                   --Menus: Bools que correspondem a cada menu;
                   --Menu1: Picture's necessárias ao menu inicial;
                   --Menu2: Picture's necessárias ao menu dos mapas assim como um Int necessário para trocar entre os diferentes mapas;
                   --Menu3: Picture necessária ao menu do número de jogadores e um Int que axilia na mudança de estados;
                   --Pause: Picture's necessárias ao menu de pausa e um Int para trocar entre estados;
                   --Estado:Estado definido no módulo LI11819;
                   --Int: tempo de jogo
type EstadoDisparos = (Picture,Picture,Picture)
type EstadoJogadores = (Picture,Picture,Picture,Picture)
type EstadoMapa = (Picture,Picture,Picture)
type Miniaturas = (Picture,Picture,Picture)
type Controlos1 = (Picture,Picture,Picture,Picture,Picture,Picture,Picture)
type Controlos2 = (Picture,Picture,Picture,Picture,Picture,Picture,Picture)
type Controlos3 = (Picture,Picture,Picture,Picture,Picture,Picture,Picture)
type Controlos4 = (Picture,Picture,Picture,Picture,Picture,Picture,Picture)
type Numeros = (Picture,Picture,Picture,Picture,Picture,Picture,Picture)
type Menus = (Bool,Bool,Bool,Bool,Bool)
type Menu1 = (Picture,Picture)
type Menu2 = (Picture,Picture,Picture,Picture,Picture,Picture,Int)
type Menu3 = (Picture,Int)
type Pause = (Picture,Picture,Int)
type Tudo = (Picture,EstadoMapa,EstadoJogadores,EstadoDisparos,Miniaturas,Controlos1,Controlos2,Controlos3,Controlos4,Numeros,Picture,Picture,Picture,Picture)
             --Picture: Background;
             --EstadoMapa: Picture's necessárias ao visionameto do Mapa (Bloco Indestrutivel, Bloco Destrutivel, Vazia);
             --EstadoJogadores: Picture's necessárias ao visionameto dos Jogadores (Jogador1,Jogador2,Jogador3,Jogador4);
             --EstadoDisparos: Picture's necessárias ao visionameto dos Disparos (Canhão, Laser, Choque);
             --Miniaturas: Picture's necessárias ao painel lateral;
             --Controlos1: Picture's necessárias ao painel lateral;
             --Controlos2: Picture's necessárias ao painel lateral;
             --Controlos3: Picture's necessárias ao painel lateral;
             --Controlos4: Picture's necessárias ao painel lateral;
             --Numeros: Picture's necessárias ao painel lateral;
             --Picture: Picture necessárias ao painel lateral;
             --Picture: Picture necessárias ao painel lateral;
             --Picture: Picture necessárias a mensagem de vitória de algum jogador;
             --Picture: Picture necessária a mensagem de fim de tempo dejogo;


-- *** Funções auxiliares para o funcionamento da função 'main'.

{- | Dadas várias Picture's e um Int, obtemos estado inicial do jogo, informação que vai aparecer quando se abre o jogo, ou seja, o estado do menu inicial. -}
estadoGlossInicial :: Picture -> Picture -> Picture-> Picture-> Picture-> Picture->Picture->Picture-> Int->Picture-> Int -> Picture -> Picture -> Int -> EstadoGloss 
estadoGlossInicial menu start menu2 mapa1 mapa2 mapa3 ret seta n menu3 n3 pause arrow np= ((True,False,False,False,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,n3),(pause,arrow,np),Estado [] [] [],0) 

{- | Mapa de jogo 1 -}
mapaJogo:: Mapa
mapaJogo = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel], [Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] 
 
{- | Mapa de jogo 2 -}
mapaJogo2::Mapa
mapaJogo2 = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]]

{- | Mapa de jogo 3 -}
mapaJogo3::Mapa
mapaJogo3 = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]]

{- 
| Função que recebe as Picture's do jogo propriamente dito (Tudo) e um EstadoGloss com um Estado e as imagens dos menus, e as converte numa única Picture
Umas das funções principais da função main
 -}
desenhaEstadoGloss :: Tudo -> EstadoGloss -> Picture
desenhaEstadoGloss _ ((True,False,False,False,False),(menu,start),_,_,_,_,_) = --desenha o estado inicial / menu inicial 
     Pictures [Scale 0.80 0.67 menu,start]


desenhaEstadoGloss (a,b,(j1,j2,j3,j4),c,d,e,f,g,h,i,j,l,m,o) ((False,True,False,False,False),_,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,1),_,_,_) = --desenha os diferentes estados do menu de escolha dos jogadores
    Pictures [menu3,Translate (-100) 0 $ Scale 1.7 1.7 j1, Translate 100 0 $ Scale 1.7 1.7 j2, Translate 200 0 seta]
desenhaEstadoGloss (a,b,(j1,j2,j3,j4),c,d,e,f,g,h,i,j,l,m,o) ((False,True,False,False,False),_,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,2),_,_,_) =
    Pictures [menu3,Translate (-100) 100 $ Scale 1.7 1.7 j1, Translate 100 100 $ Scale 1.7 1.7 j2,Translate 0 (-100) $ Scale 1.7 1.7 j3, Translate 200 0 seta,Translate (-200) 0 $ Rotate 180 seta]
desenhaEstadoGloss (a,b,(j1,j2,j3,j4),c,d,e,f,g,h,i,j,l,m,o) ((False,True,False,False,False),_,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,3),_,_,_) =
    Pictures [menu3,Translate (-100) 100 $ Scale 1.7 1.7 j1, Translate 100 100 $ Scale 1.7 1.7 j2,Translate (-100) (-100) $ Scale 1.7 1.7 j3,Translate 100 (-100) $ Scale 1.7 1.7 j4, Translate (-200) 0 $ Rotate 180 seta]

desenhaEstadoGloss _ ((False,False,True,False,False),_,(menu2,mapa1,mapa2,mapa3,ret,seta,0),_,_,_,_) = --desenha cada um dos estados do menu de escolha dos mapas
     Pictures [menu2,mapa1,ret,Translate 380 0 seta]
desenhaEstadoGloss _ ((False,False,True,False,False),_,(menu2,mapa1,mapa2,mapa3,ret,seta,1),_,_,_,_) = 
     Pictures [menu2,Scale 0.90 0.90 mapa2,ret,Translate 380 0 seta,Translate (-380) 0 $ Rotate 180 seta]
desenhaEstadoGloss _ ((False,False,True,False,False),_,(menu2,mapa1,mapa2,mapa3,ret,seta,2),_,_,_,_) = 
     Pictures [menu2,Scale 0.90 0.90 mapa3,ret,Translate (-380) 0 $ Rotate 180 seta]

desenhaEstadoGloss tudo@(back,(bi,bd,v),(j1,j2,j3,j4),(tiro,laser,choque),(heart,beam,thunder),(w,a,s,d,one,two,three),(q,b,e,r,t,y,u),(i,j,k,l,comma,dot,dash),(t1,f,g,h,four,five,six),(up,left,down,right,seven,eight,nine),retangulo,retangulo2,winner,times) est@((False,False,False,True,False),z,z1,z2,(pause,arrow,int),Estado ms js ds,tmp) = -- desenha o estado de jogo propriamente dito
     Pictures [back,Translate (-80) (-160) (Pictures (mapaPicture ms (-1,-1) (dimensaoMapa ms) (bi,bd,v))), 
                    Translate (-80) (-160) (Pictures (jogadoresPicture js (dimensaoMapa ms) (j1,j2,j3,j4) 0)), 
                    Translate (-80) (-160) (Pictures (disparosPicture ds (Estado ms js ds) (dimensaoMapa ms) (tiro,laser,choque))), 
                    painelLateral tudo est]

desenhaEstadoGloss tudo ((False,False,False,False,True),z,z1,z2,(pause,arrow,0),Estado ms js ds,tmp) = -- desenha o menu de pausa, por cima da tela parada de jogo
     Pictures [desenhaEstadoGloss tudo ((False,False,False,True,False),z,z1,z2,(pause,arrow,0),Estado ms js ds,tmp), pause,Translate (-150) 60 arrow]
desenhaEstadoGloss tudo ((False,False,False,False,True),z,z1,z2,(pause,arrow,1),Estado ms js ds,tmp) =
     Pictures [desenhaEstadoGloss tudo ((False,False,False,True,False),z,z1,z2,(pause,arrow,1),Estado ms js ds,tmp), pause, Translate (-150) 0 arrow ]
desenhaEstadoGloss tudo ((False,False,False,False,True),z,z1,z2,(pause,arrow,2),Estado ms js ds,tmp) =
     Pictures [desenhaEstadoGloss tudo ((False,False,False,True,False),z,z1,z2,(pause,arrow,2),Estado ms js ds,tmp), pause, Translate (-150) (-60) arrow ]

{- 
| Função que recebe 'Tudo' e um EstadoGloss e dá uma Picture.
Esta Picture corresponde aos paineis laterais com informação de cada jogador, assim como o temporizador.
-}
painelLateral :: Tudo -> EstadoGloss -> Picture
painelLateral (back,(bi,bd,v),(j1,j2,j3,j4),(tiro,laser,choque),(heart,beam,thunder),(w,a,s,d,one,two,three),(q,b,e,r,t,y,u),(i,j,k,l,comma,dot,dash),(t1,f,g,h,four,five,six),(up,left,down,right,seven,eight,nine),retangulo,retangulo2,winner,times) ((bool,bool2,bool3,bool4,bool5),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,n),menu3,pause,Estado ms (Jogador (xs,ys) dir vidas l1 c:Jogador (xs2,ys2) dir2 vidas2 l2 c2: Jogador (xs3,ys3) dir3 vidas3 l3 c3:Jogador (xs4,ys4) dir4 vidas4 l4 c4:ts) ds, tmp) = 
       Pictures [Translate 610 200 $ Scale 1.7 1.7 j2,
                 Translate 610 200  retangulo, 
                   Translate 560 120 $ Scale 0.85 0.85  w, Translate 592 120 $ Scale 0.85 0.85  a, Translate 624 120 $ Scale 0.85 0.85  s, Translate 656 120 $ Scale 0.85 0.85  d,
                   Translate 576 89 $ Scale 0.85 0.85  one, Translate 608 89 $ Scale 0.85 0.85  two, Translate 640 89 $ Scale 0.85 0.85  three,
                      Translate 520 250  heart, Translate 520 210  beam, Translate 520 170  thunder,
                        Translate 483 253 $ Scale 0.65 0.65  (trocaNumero vidas2 (q,b,e,r,t,y,u)), Translate 483 213 $ Scale 0.65 0.65  (trocaNumero l2 (q,b,e,r,t,y,u)), Translate 483 173 $ Scale 0.65 0.65 (trocaNumero c2 (q,b,e,r,t,y,u)),
                        if vidas2== 0 then Translate 610 200 retangulo2 else Blank,
                          if vidas==0 && vidas3==0 && vidas4==0 then Pictures [Translate 0 0 winner, Translate 0 0 j2] else Blank,

                        Translate 610 (-100) $ Scale 1.7 1.7 j4,
                 Translate 610 (-100) retangulo, 
                   Translate 560 (-180) $ Scale 0.85 0.85  i, Translate 592 (-180) $ Scale 0.85 0.85 j, Translate 624 (-180) $ Scale 0.85 0.85 k, Translate 656 (-180) $ Scale 0.85 0.85 d,
                   Translate 576 (-211) $ Scale 0.85 0.85 comma, Translate 608 (-211) $ Scale 0.85 0.85 dot, Translate 640 (-211) $ Scale 0.85 0.85 dash,
                      Translate 520 (-50) heart, Translate 520 (-90) beam, Translate 520 (-130) thunder,
                        Translate 483 (-47) $ Scale 0.65 0.65 (trocaNumero vidas4 (q,b,e,r,t,y,u)), Translate 483 (-87) $ Scale 0.65 0.65 (trocaNumero l4 (q,b,e,r,t,y,u)), Translate 483 (-127) $ Scale 0.65 0.65 (trocaNumero c4 (q,b,e,r,t,y,u)),
                        if vidas4== 0 then Translate 610 (-100) retangulo2 else Blank,
                          if vidas==0 && vidas3==0 && vidas2==0 then Pictures [Translate 0 0 winner, Translate 0 0 j4] else Blank,

                        Translate (-610) 200 $ Scale 1.7 1.7 j1,                    
                 Translate (-610) 200 retangulo, 
                   Translate (-560) 120 $ Scale 0.85 0.85 right, Translate (-592) 120 $ Scale 0.85 0.85 down, Translate (-624) 120 $ Scale 0.85 0.85 left, Translate (-656) 120 $ Scale 0.85 0.85 up,
                   Translate (-576) 89 $ Scale 0.85 0.85 nine, Translate (-608) 89 $ Scale 0.85 0.85 eight, Translate (-640) 89 $ Scale 0.85 0.85 seven,
                      Translate (-520) 250 heart, Translate (-520) 210 beam, Translate (-520) 170 thunder,
                        Translate (-483) 253 $ Scale 0.65 0.65 (trocaNumero vidas (q,b,e,r,t,y,u)), Translate (-483) 213 $ Scale 0.65 0.65 (trocaNumero l1 (q,b,e,r,t,y,u)), Translate (-483) 173 $ Scale 0.65 0.65 (trocaNumero c (q,b,e,r,t,y,u)),
                        if vidas== 0 then Translate (-610) 200 retangulo2 else Blank,
                          if vidas3==0 && vidas2==0 && vidas4==0 then Pictures [Translate 0 0 winner, Translate 0 0 j1] else Blank,

                        Translate (-610) (-100) $ Scale 1.7 1.7 j3,
                 Translate (-610) (-100) retangulo, 
                   Translate (-560) (-180) $ Scale 0.85 0.85 h, Translate (-592) (-180) $ Scale 0.85 0.85 g, Translate (-624) (-180) $ Scale 0.85 0.85 f, Translate (-656) (-180) $ Scale 0.85 0.85 t1,
                   Translate (-576) (-211) $ Scale 0.85 0.85 six, Translate (-608) (-211) $ Scale 0.85 0.85 five, Translate (-640) (-211) $ Scale 0.85 0.85 four,
                      Translate (-520) (-50) heart, Translate (-520) (-90) beam, Translate (-520) (-130) thunder,
                        Translate (-483) (-47) $ Scale 0.65 0.65 (trocaNumero vidas3 (q,b,e,r,t,y,u)), Translate (-483) (-87) $ Scale 0.65 0.65 (trocaNumero l3 (q,b,e,r,t,y,u)), Translate (-483) (-127) $ Scale 0.65 0.65 (trocaNumero c3 (q,b,e,r,t,y,u)),
                        if vidas3== 0 then Translate (-610) (-100) retangulo2 else Blank,
                          if vidas2==0 && vidas==0 && vidas4==0 then Pictures [Translate 0 0 winner, Translate 0 0 j3] else Blank, 

                 Translate (-20) (-250) $ Scale 0.3 0.3 $ text (show tmp),
                   if tmp==200 then times else Blank --o jogo acaba quando chega a 200 ticks ou há apenas um jogador vivo.

                        ]

{- 
|Função q a cada Int faz corresponder uma imagem.
Esta função é utilizada para mostrar o número de vidas, lasers e choques de cada jogador 
-}
trocaNumero:: Int -> Numeros -> Picture
trocaNumero 0 (a,b,c,d,e,f,g) = a
trocaNumero 1 (a,b,c,d,e,f,g) = b
trocaNumero 2 (a,b,c,d,e,f,g) = c
trocaNumero 3 (a,b,c,d,e,f,g) = d
trocaNumero 4 (a,b,c,d,e,f,g) = e
trocaNumero 5 (a,b,c,d,e,f,g) = f
trocaNumero 6 (a,b,c,d,e,f,g) = g


{- | Função auxiliar da listaPicture. -}
xPos::Int -> Int -> Float
xPos y cs= (fromIntegral y-(fromIntegral cs/2))*35

{- | Função auxiliar da listaPicture. -}
yPos::Int -> Int -> Float
yPos x ls = (fromIntegral ls/2 - (fromIntegral x))*35

{- 
| Função que dada uma lista de Peca's, uma posição, a dimensao (do mapa), e um EstadoMapa, mete cada imagem correspondente a peça no sitio certo.
Pois enquanto o (0,0) do mapa é no canto, o (0,0) do gloss é no centro do ecra. Além disso multiplicamos por 35 visto ser a dimensao (em px) de cada imagem correspondente a um bloco 
-}
listaPicture:: [Peca] -> Posicao -> Dimensao -> EstadoMapa -> [Picture]
listaPicture [] _ _ _ = []
listaPicture (Vazia:t) (x,y) (ls,cs) (bi,bd,v) = 
   Translate (xPos y cs) (yPos x ls) v : listaPicture t (x,y+1) (ls,cs) (bi,bd,v)
listaPicture (Bloco Indestrutivel:t) (x,y) (ls,cs) (bi,bd,v) = 
   Translate(xPos y cs) (yPos x ls) bi : listaPicture t (x,y+1) (ls,cs) (bi,bd,v)
listaPicture (Bloco Destrutivel:t) (x,y) (ls,cs) (bi,bd,v) = 
   Translate (xPos y cs) (yPos x ls) bd : listaPicture t (x,y+1) (ls,cs) (bi,bd,v)

{- 
| Função complementar da listaPicture mas desta vez para Mapas.
Uma das funções principais necessárias ao funcionamento da desenhaEstadoGloss
-}
mapaPicture:: Mapa -> Posicao -> Dimensao -> EstadoMapa -> [Picture]
mapaPicture [] _ _ _ = []
mapaPicture (h:t) (x,y) (ls,cs) em = Pictures (listaPicture h (x,y) (ls,cs) em) : mapaPicture t (x+1,y) (ls,cs) em


{- | Função que dado um jogador e uma Picture, dá uma Picture que fica de acordo com a direção do jogador. -}
rodaJogador :: Jogador -> Picture -> Picture
rodaJogador (Jogador (x,y) d v l c) j | d==B = j
                                      | d==C = Rotate 180 j
                                      | d==E = Rotate 90 j
                                      | d==D = Rotate 270 j
                                      |otherwise = Blank

{- | Função auxiliar da jogadorPicture. -}
xJog::Int-> Int -> Float
xJog y cs= (fromIntegral y-(fromIntegral cs/2)-0.5)*35 

{- | Função auxiliar da jogadorPicture. -}
yJog::Int -> Int -> Float
yJog x ls = ((fromIntegral ls/2) - fromIntegral x +0.5)*35

{- 
| Função que dado um Jogador, uma dimensão (do mapa), um EstadoJogadores que tem uma imagem para cada um dos quatro jogadores, e um Int que funciona como identificador do jogador, dá uma Picture correspondente a cada Jogador
Mais uma vez, a posição de um Jogador no mapa não é a mesma posição no gloss, daí serem precisos Translates das Pictures.
-}
jogadorPicture:: Jogador -> Dimensao -> EstadoJogadores -> Int -> Picture
jogadorPicture j@(Jogador (x,y) d v l c) (ls,cs) (j1,j2,j3,j4) n | v==0 = Blank
                                                                 | n==0 = Translate (xJog y cs) (yJog x ls) (rodaJogador j j1)
                                                                 | n==1 = Translate (xJog y cs) (yJog x ls) (rodaJogador j j2)
                                                                 | n==2 = Translate (xJog y cs) (yJog x ls) (rodaJogador j j3)
                                                                 | n==3 = Translate (xJog y cs) (yJog x ls) (rodaJogador j j4)
                                                                 | otherwise = Blank

{- 
| Função complementar da jogadorPicture mas desta vez para uma lista de Jogador's.
Uma das funções principais necessárias ao funcionamento da desenhaEstadoGloss.
-}
jogadoresPicture:: [Jogador] -> Dimensao -> EstadoJogadores -> Int -> [Picture]
jogadoresPicture [] _ _ _ = []
jogadoresPicture (j:js) (ls,cs) ej@(j1,j2,j3,j4) n = Pictures [jogadorPicture j (ls,cs) ej n] : jogadoresPicture js (ls,cs) ej (n+1)


{- | Função que dado um Disparo e um Picture, dá a picture correspondente ao laser rodada.
É preciso fazer esta função uma vez que o x e o y do mapa sao trocados -}
rodaLaser:: Disparo -> Picture -> Picture
rodaLaser (DisparoLaser i (x,y) d) l | d==B || d==C = Rotate 90 l
                                     |otherwise = l

{- distancia :: Estado -> Int
distancia (Estado m (Jogador (x,y) d v l c:t) ds)
         | encontraPosicaoMatriz (posSegDoJog (x,y) d) m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosSegDoJog (x,y) d) m /= Bloco Indestrutivel = 
           1 + distancia (Estado m (Jogador (posSeg (x,y) d) d v l c:t) ds)
         | encontraPosicaoMatriz (posSegDoJog (x,y) d) m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosSegDoJog (x,y) d) m == Bloco Indestrutivel = 0
         | otherwise = 0

disparoLaser :: Disparo -> Estado -> Dimensao -> EstadoDisparos -> [Picture]
disparoLaser (DisparoLaser i (x,y) d) (Estado m (Jogador (a,b) s v l c:t) ds) (ls,cs) (tiro,laser,choque)=
    replicate (distancia (Estado m (Jogador (x,y) d v l c:t) ds)) 
         (Translate (((fromIntegral y)-(fromIntegral cs/2)-0.5)*35) (((fromIntegral ls/2) - fromIntegral x )*35) (rodaLaser (DisparoLaser i (x,y) d) laser))
     
listaLaser :: Int -> Direcao -> Posicao ->[Picture] -> [Picture]
listaLaser 0 _ _ _= []
listaLaser _  _ _ [] = []
listaLaser _ _ _ [p] = [p]
listaLaser n d (x,y) (p:ps) | d==B = p : Translate ((fromIntegral x)-2) ((fromIntegral y)-34.5) (head ps) : listaLaser (n-1) d (x,y) ps
                            | d==C = p : Translate (fromIntegral (x-1)) (fromIntegral y) (head ps) : listaLaser (n-1) d (x,y) ps
                            | d==E = p : Translate (fromIntegral x) (fromIntegral (y-1)) (head ps) : listaLaser (n-1) d (x,y) ps
                            | d==D = p : Translate (fromIntegral x) (fromIntegral (y+1)) (head ps) : listaLaser (n-1) d (x,y) ps
                            | otherwise = [Blank]

lstLaser :: Direcao -> Posicao ->[Picture] -> [Picture]
lstLaser _ _ [] = []
lstLaser d (x,y) (p:ps) | d==B = p: lstLaser d (x,y) (map tr ps) 
                        | d==D = p: lstLaser d (x,y) (map tr2 ps)
                        | d==E = p: lstLaser d (x,y) (map tr3 ps)
                        | d==D = p: lstLaser d (x,y) (map tr3 ps)
              where tr p = Translate (fromIntegral x) ((fromIntegral y)-35) p
                    tr2 p = Translate ((fromIntegral x)+35) (fromIntegral y) p
                    tr3 p = Translate ((fromIntegral x)-35) (fromIntegral y) p
                    tr4 p = Translate (fromIntegral x) ((fromIntegral y)+35) p -}

{- | Função que dado um Jogador, dá a sua Posicao -}
posJog :: Jogador -> Posicao
posJog (Jogador (x,y) d v l c) = (x,y)

{-
| Função que dado um Disparo, um Estado , uma dimensão (do mapa), e um EstadoDisparos (imagens correspondentes aos diferentes tipos de disparos), dá uma Picture correspondente ao Disparo no sitio certo.
Mais uma vez, a posição de um Disparo no mapa não é a mesma posição no gloss, daí serem precisos Translates das Pictures.
-}
disparoPicture:: Disparo -> Estado -> Dimensao -> EstadoDisparos -> Picture
disparoPicture (DisparoCanhao i (x,y) d) _ (ls,cs) (tiro,laser,choque) = 
    Translate (xJog y cs) (yJog x ls) tiro
disparoPicture (DisparoLaser i (x,y) d) e (ls,cs) (tiro,laser,choque) = 
    Translate (xJog y cs) (yJog x ls) (rodaLaser (DisparoLaser i (x,y) d) laser)
disparoPicture (DisparoChoque i n) (Estado ms (Jogador (a,b) s v l c:t) ds) (ls,cs) (tiro,laser,choque) = 
    Translate x1 x2 choque
          where x1 = (fromIntegral (snd(posJog (encontraIndiceLista i (Jogador (a,b) s v l c:t))))-(fromIntegral cs/2)-0.5)*35 -- no choque, como o DisparoChoque não tinha uma posição, tivemos de usar o i para ir buscar a posição do jogador
                x2 = ((fromIntegral ls/2) - fromIntegral (fst(posJog (encontraIndiceLista i (Jogador (a,b) s v l c:t))))+0.5)*35  

{- 
| Função complementar da disparosPicture mas desta vez para uma lista de Disparo's.
Uma das funções principais necessárias ao funcionamento da desenhaEstadoGloss.
-}
disparosPicture:: [Disparo] -> Estado -> Dimensao -> EstadoDisparos -> [Picture]
disparosPicture [] _ _ _= []
disparosPicture (d:ds) js (ls,cs) ed@(tiro,laser,choque) = Pictures [disparoPicture d js (ls,cs) ed] : disparosPicture ds js (ls,cs) ed

{-
| Função que recebe um Evento, um EstadoGloss e dá o EstadoGloss resultante de tal Evento.
Esta função define comandos/controlos ao jogo e permite trocar entre os diferentes menus
Esta função utiliza de forma intensiva a função jogada da tarefa2.
Uma das fuções necessárias ao funcionamento da função main.
-}
reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
reageEventoGloss (EventKey (SpecialKey KeySpace)    Down _ _) ((True,False,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,n3),p,e,tmp) = ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,1),p,e,0) -- troca entre o menu inicial e o menu de escolha dos jogadores
reageEventoGloss (EventKey (SpecialKey KeyRight)    Down _ _) ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,1),p,e,tmp) = ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,2),p,e,0) -- troca entre os diferentes números de jogadores
reageEventoGloss (EventKey (SpecialKey KeyRight)    Down _ _) ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,2),p,e,tmp) = ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,3),p,e,0)
reageEventoGloss (EventKey (SpecialKey KeyLeft)    Down _ _) ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,3),p,e,tmp) = ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,2),p,e,0) 
reageEventoGloss (EventKey (SpecialKey KeyLeft)    Down _ _) ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,2),p,e,tmp) = ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,1),p,e,0) 
reageEventoGloss (EventKey (SpecialKey KeySpace)    Down _ _) ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,n3),p,e,tmp) = ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),(menu3,n3),p,e,0) -- troca entre o menu de escolha do número de jogadores e o menu dos mapas
reageEventoGloss (EventKey (SpecialKey KeyRight)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),m3,p,e,tmp) = ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),m3,p,e,0) -- troca entres os diferentes mapas
reageEventoGloss (EventKey (SpecialKey KeyRight)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),m3,p,e,tmp) = ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,2),m3,p,e,0)
reageEventoGloss (EventKey (SpecialKey KeyLeft)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,2),m3,p,e,tmp) = ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),m3,p,e,0)
reageEventoGloss (EventKey (SpecialKey KeyLeft)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),m3,p,e,tmp) = ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),m3,p,e,0) 
reageEventoGloss (EventKey (SpecialKey KeyTab)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,n3),p,e,tmp) = ((False,True,False,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,1),p,e,tmp) -- permite voltar ao menu anterior
reageEventoGloss (EventKey (SpecialKey KeySpace)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),(menu3,n3),p,e,tmp) 
                                                                                                                                                 | n3==1 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),(menu3,n3),p,Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                                 | n3==2 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),(menu3,n3),p,Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                                 | n3==3 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),(menu3,n3),p,Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0) -- troca entre o menu dos mapas e o jogo com o mapa selecionado
reageEventoGloss (EventKey (SpecialKey KeySpace)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),(menu3,n3),p,e,tmp) 
                                                                                                                                                 | n3==1 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),(menu3,n3),p,Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                                 | n3==2 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),(menu3,n3),p,Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                                 | n3==3 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,1),(menu3,n3),p,Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0) -- troca entre o menu dos mapas e o jogo com o mapa selecionado
reageEventoGloss (EventKey (SpecialKey KeySpace)    Down _ _) ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,2),(menu3,n3),p,e,tmp) 
                                                                                                                                                 | n3==1 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,2),(menu3,n3),p,Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                                 | n3==2 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,2),(menu3,n3),p,Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                                 | n3==3 = ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,2),(menu3,n3),p,Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0) -- troca entre o menu dos mapas e o jogo com o mapa selecionado

reageEventoGloss (EventKey (SpecialKey KeyUp)    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Movimenta C) (Estado ms js ds),tmp) --controlos do jogador 1
reageEventoGloss (EventKey (SpecialKey KeyDown)    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Movimenta B) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (SpecialKey KeyRight)    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Movimenta D) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (SpecialKey KeyLeft)    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Movimenta E) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '7')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Dispara Canhao) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '8')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Dispara Laser) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '9')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 0 (Dispara Choque) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'w')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Movimenta C) (Estado ms js ds),tmp) -- controlos do jogador 2
reageEventoGloss (EventKey (Char 'a')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Movimenta E) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 's')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Movimenta B) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'd')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Movimenta D) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '1')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Dispara Canhao) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '2')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Dispara Laser) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '3')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 1 (Dispara Choque) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 't')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Movimenta C) (Estado ms js ds),tmp) --controlos do jogador 3
reageEventoGloss (EventKey (Char 'f')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Movimenta E) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'g')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Movimenta B) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'h')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Movimenta D) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '4')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Dispara Canhao) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '5')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Dispara Laser) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '6')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 2 (Dispara Choque) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'i')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Movimenta C) (Estado ms js ds),tmp) --controlos do jogador 4
reageEventoGloss (EventKey (Char 'j')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Movimenta E) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'k')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Movimenta B) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char 'l')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Movimenta D) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char ',')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Dispara Canhao) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '.')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Dispara Laser) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (Char '-')    Down _ _) ((False,False,False,True,False),m,m2,m3,p,Estado ms js ds,tmp) = ((False,False,False,True,False),m,m2,m3,p,jogada 3 (Dispara Choque) (Estado ms js ds),tmp)
reageEventoGloss (EventKey (SpecialKey KeyTab)    Down _ _) ((False,False,False,True,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,n3),p,e,tmp) = ((False,False,True,False,False),m,(menu2,mapa1,mapa2,mapa3,ret,seta,0),(menu3,1),p,e,tmp) --permite voltar ao menu anterior
reageEventoGloss (EventKey (Char 'y')    Down _ _) ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado ms js ds,tmp) | encontraPosicaoMatriz (6,10) ms== Bloco Destrutivel && n3==3 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Bloco Destrutivel && n3==2 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Bloco Destrutivel && n3==1 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Vazia && n3==3 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Vazia && n3==2 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Vazia && n3==1 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Bloco Indestrutivel && n3==3 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Bloco Indestrutivel && n3==2 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                  | encontraPosicaoMatriz (6,10) ms== Bloco Indestrutivel && n3==1 = ((False,False,False,True,False),m,m2,(menu3,n3),p,Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0) -- faz reset ao mapa atual
reageEventoGloss (EventKey (Char 'm')    Down _ _) ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,n),(menu3,n3),(pause,arrow,np),e,tmp) = estadoGlossInicial menu start menu2 mapa1 mapa2 mapa3 ret seta n menu3 n3 pause arrow np-- volta ao menu inicial 
reageEventoGloss (EventKey (Char 'p')    Down _ _) ((False,False,False,True,False),z,z1,z2,(pause,arrow,int),Estado ms js ds,tmp) = ((False,False,False,False,True),z,z1,z2,(pause,arrow,int),Estado ms js ds,tmp) -- pausa o jogo
reageEventoGloss (EventKey (SpecialKey KeySpace)    Down _ _) ((False,False,False,False,True),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado ms js ds,tmp) 
                                                                                                                                           | n== 0 = ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,0),Estado ms js ds,tmp) -- continua o jogo
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Bloco Destrutivel && n3==3 = ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Bloco Destrutivel && n3==2= ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Bloco Destrutivel && n3==1= ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Vazia && n3==3 = ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Vazia && n3==2 = ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Vazia && n3==1= ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo2 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Bloco Indestrutivel && n3==3 = ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 6 3 3,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Bloco Indestrutivel && n3==2= ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 6 3 3,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0)
                                                                                                                                           | n== 1 && encontraPosicaoMatriz (6,10) ms== Bloco Indestrutivel && n3==1= ((False,False,False,True,False),(menu,start),(menu2,mapa1,mapa2,mapa3,ret,seta,np),(menu3,n3),(pause,arrow,n),Estado mapaJogo3 [Jogador (1,1) B 6 3 3,Jogador (1,17) B 0 0 0,Jogador (10,1) C 0 0 0,Jogador (10,17) C 6 3 3] [],0) --faz reset do mapa atual mas no menu de pausa
                                                                                                                                           | n == 2 = estadoGlossInicial menu start menu2 mapa1 mapa2 mapa3 ret seta np menu3 n3 pause arrow n -- volta ao ecra inicial
reageEventoGloss (EventKey (SpecialKey KeyDown)    Down _ _) ((False,False,False,False,True),z,z1,z2,(pause,arrow,0),Estado ms js ds,tmp) = ((False,False,False,False,True),z,z1,z2,(pause,arrow,1),Estado ms js ds,tmp)
reageEventoGloss (EventKey (SpecialKey KeyDown)    Down _ _) ((False,False,False,False,True),z,z1,z2,(pause,arrow,1),Estado ms js ds,tmp) = ((False,False,False,False,True),z,z1,z2,(pause,arrow,2),Estado ms js ds,tmp)
reageEventoGloss (EventKey (SpecialKey KeyUp)    Down _ _) ((False,False,False,False,True),z,z1,z2,(pause,arrow,2),Estado ms js ds,tmp) = ((False,False,False,False,True),z,z1,z2,(pause,arrow,1),Estado ms js ds,tmp)
reageEventoGloss (EventKey (SpecialKey KeyUp)    Down _ _) ((False,False,False,False,True),z,z1,z2,(pause,arrow,1),Estado ms js ds,tmp) = ((False,False,False,False,True),z,z1,z2,(pause,arrow,0),Estado ms js ds,tmp)-- troca entre as diferentes opções do menu de pausa
reageEventoGloss _ s = s -- ignora qualquer outro evento 


{-
| Função que dado um Float e um EstadoGloss, dá o EstadoGloss seguinte.
Esta função resume-se a aplicar a função tick definida na Tarefa4.
Uma das funções necessárias ao funcionamento da função main.
-}
reageTempoGloss :: Float -> EstadoGloss -> EstadoGloss
reageTempoGloss _ (b,m,m2,m3,p,e,n) | b==(False,False,False,False,True) = (b,m,m2,m3,p,e,n) --para o tempo e as ações quando esté no menu de pausa
                                    | jogadoresVivos e == 1 || n == 200 = (b,m,m2,m3,p,tick e,n)
                                    | otherwise = (b,m,m2,m3,p,tick e,n+1)

{- | Função que dado um Estado, dá um Int correspondente ao número de jogadores vivos -}
jogadoresVivos :: Estado -> Int
jogadoresVivos (Estado m [] ds) = 0
jogadoresVivos (Estado m (Jogador (x,y) d v l c:js) ds) | v>0 = 1 +  jogadoresVivos (Estado m js ds)
                                                        | otherwise = jogadoresVivos (Estado m js ds)

{- | Frame rate do jogo -}
fr :: Int
fr = 5

{- | Janela onde vai correr o jogo -}
dm :: Display
dm = FullScreen
 


-- * Função principal da Tarefa 5.       
main :: IO ()
main = do Just bi <- loadJuicy "imagens/indestrutivel.jpg"
          Just bd <- loadJuicy "imagens/destrutivel.jpg"
          Just v <- loadJuicy "imagens/vazia.jpg"
          Just back <- loadJuicy "imagens/background3.jpg"
          Just j1 <- loadJuicy "imagens/sub1.png"
          Just j2 <- loadJuicy "imagens/sub2.png"
          Just j3 <- loadJuicy "imagens/sub3.png"
          Just j4 <- loadJuicy "imagens/sub4.png"
          Just tiro <- loadJuicy "imagens/tiro.png"
          Just laser <- loadJuicy "imagens/laser.png"
          Just choque <- loadJuicy "imagens/choque.png"
          Just heart <- loadJuicy "imagens/heart.png"
          Just beam <-loadJuicy "imagens/minilaser.png"
          Just thunder <-loadJuicy "imagens/thunder.png"
          Just w <-loadJuicy "imagens/w.jpg"
          Just a <-loadJuicy "imagens/a.jpg"
          Just s <-loadJuicy "imagens/s.jpg"
          Just d <-loadJuicy "imagens/d.jpg"
          Just one <-loadJuicy "imagens/1.jpg"
          Just two <-loadJuicy "imagens/2.jpg"
          Just three <-loadJuicy "imagens/3.jpg"
          Just q <-loadJuicy "imagens/0.png"
          Just c <-loadJuicy "imagens/1.png"
          Just e <-loadJuicy "imagens/2.png"
          Just r <-loadJuicy "imagens/3.png"
          Just t <-loadJuicy "imagens/4.png"
          Just y <-loadJuicy "imagens/5.png"
          Just u <-loadJuicy "imagens/6.png"
          Just retangulo <-loadJuicy "imagens/retangulo.png"
          Just retangulo2 <-loadJuicy "imagens/retangulo2.png"
          Just i <- loadJuicy "imagens/i.jpg"
          Just j <- loadJuicy "imagens/j.jpg"
          Just k <- loadJuicy "imagens/k.jpg"
          Just l <- loadJuicy "imagens/l.jpg"
          Just comma <- loadJuicy "imagens/comma.jpg"
          Just dot <- loadJuicy "imagens/dot.jpg"
          Just dash <- loadJuicy "imagens/dash.jpg"
          Just t1 <- loadJuicy "imagens/t.jpg"
          Just f <- loadJuicy "imagens/f.jpg"
          Just g <- loadJuicy "imagens/g.jpg"
          Just h <- loadJuicy "imagens/h.jpg"
          Just four <- loadJuicy "imagens/4.jpg"
          Just five <- loadJuicy "imagens/5.jpg"
          Just six <- loadJuicy "imagens/6.jpg"
          Just up  <- loadJuicy "imagens/up.jpg"
          Just left  <- loadJuicy "imagens/left.jpg"
          Just down  <- loadJuicy "imagens/down.jpg"
          Just right  <- loadJuicy "imagens/right.jpg"
          Just seven  <- loadJuicy "imagens/7.jpg"
          Just eight  <- loadJuicy "imagens/8.jpg"
          Just nine <- loadJuicy "imagens/9.jpg"
          Just menu <- loadJuicy "imagens/menu1.jpg"
          Just start <- loadJuicy "imagens/start.png"
          Just winner <- loadJuicy "imagens/winner.jpg"
          Just menu2 <- loadJuicy "imagens/menu2.jpg"
          Just mapa1 <- loadJuicy "imagens/mapa1.jpg"
          Just mapa2 <- loadJuicy "imagens/mapa2.jpg"
          Just mapa3 <- loadJuicy "imagens/mapa3.jpg"
          Just ret <- loadJuicy "imagens/mapselec.png"
          Just seta <- loadJuicy "imagens/seta.png"
          Just tempo <- loadJuicy "imagens/timesup.jpg"
          Just menu3 <- loadJuicy "imagens/menu3.jpg"
          Just pause <- loadJuicy "imagens/pause.png"
          Just arrow <- loadJuicy "imagens/arrow.png"


          play 
           dm                   -- janela onde irá correr o jogo
           black             -- côr do fundo da janela
           fr                      -- frame rate
           (estadoGlossInicial menu start menu2 mapa1 mapa2 mapa3 ret seta 5 menu3 5 pause arrow 0)-- estado inicial
           (desenhaEstadoGloss (back,(bi,bd,v),(j1,j2,j3,j4),(tiro,laser,choque),(heart,beam,thunder),(w,a,s,d,one,two,three),(q,c,e,r,t,y,u),(i,j,k,l,comma,dot,dash),(t1,f,g,h,four,five,six),(up,left,down,right,seven,eight,nine),retangulo,retangulo2,winner,tempo))       -- desenha o estado do jogo
           reageEventoGloss        -- reage a um evento
           reageTempoGloss         -- reage ao passar do tempo

-- * Conclusão 

-- *** Na medida em que esta Tarefa era livre, pensamos ter atingido os objetivos e as espetativas criadas no inicio da tarefa. Assim sendo, apresentamos agora um breve sumário dos pontos positivos e dos negativos:

-- ***Pontos Positivos:
-- ***1º --> Conseguimos criar um jogo original e de certa forma diferente dos restantes, pelo menos na vertente artistica;
-- ***2º --> Conseguimos um jogo fluido e interativo com vários menus e opções de jogo;
-- ***3º --> Esforçamo-nos para manter o código eficiente, ordenado,conciso e legivel;
-- ***5º --> Conseguimos aproveitar de forma eficiente a biblioteca do gloss e as suas funcionalidades;
-- ***6º --> Aliado às tarefas anteriores, fizemos bom uso das funções definidas anteriormente;

-- ***Pontos Negativos:
-- ***1º --> O laser foi, de facto, a nossa maior falha, como é obvio, não conseguimos visualizar de forma correta este disparo, no entanto, estavamos bastante perto de o conseguir fazer. 
--           É de notar que tinhamos uma função que tinha o número certo de Pictures correspondententes às diferentes posições ocupadas pelo laser, apesar disso, tais Pictures ficavam todas no mesmo sítio, não sendo possível observar o laser na sua totalidade.
--           Faltavas-nos então uma função que dada tal lista de Picture's, as colocasse no lugar certo no ecrã.
-- ***2º --> Código repetitivo e com más praticas de programação.
-- ***3º --> A falta de implementação de bots no jogo.

-- *** Em conclusão, esta foi uma tarefa que se revelou bastante trabalhosa mas que nos cativou dado apelar ao nosso sentido artistico e criativo, facto que se refletiu na qualidade do nosso jogo.


