{-|
Module      : Tarefa3_2018li1g141
Description : Modulo que comprime um estado para mais tarde o descomprimir outra vez.
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;
O objectivo desta tarefa é, dada um estado do jogo comprimir este numa String de modo a mais tarde poder descomprir-lo sem perder nenhuma informação.
-}

module Tarefa3_2018li1g141 where

import LI11819
import Tarefa0_2018li1g141
import Tarefa1_2018li1g141
import Tarefa2_2018li1g141
import Data.List
import Data.Char
import Data.String
import Data.List.Split


-- * Introdução 

-- *** Nesta tarefa foi-nos proposto a realização de uma função capaz de comprimir um estado e outra função que mais tarde fosse descomprimir o resultado da primeira de modo a que se obtenha o mesmo estado sem perder nenhuma informação. 



-- * Objetivos da Compressão

-- *** A nossa estratégia nesta tarefa foi começar com comprimir o estado por partes. Começando pelo mapa :
-- *** -> Se a linha do mapa for composta apenas por blocos indestrutiveis vemos o comprimento da linha, o número de elementos, e usamos a função 'chr' (dado um inteiro dá um Char) para mais tarde ser fácil de descomprimir. 
-- *** -> Se a linha não for composta apenas por blocos indestrutiveis, vamos ver se a linha só tem dois blocos indestrutiveis. Se assim for são as paredes e o resto da linha será toda vazia, identificamos então a linha metendo o símbolo "!" mais o chr da dimensão da linha.
-- *** -> Se a linha tiver mais que dois blocos e não for composta apenas por blocos indestrutíveis vamos comprimir elemento por elemento, sendo que se for bloco indestrutivel adicionamos um "1", se for destrutivel "2" e se for vazia "0". Cada vez que comprimimos uma linha no fim adicionamos uma virgula para ser mais facil distinguir as linhas e mais tarde descomprimir-las mais facilmente.
-- *** De seguida vamos comprimir a lista de jogadores, para isso comprimimos para elemento do jogador (posição,vidas,numero de lasers,numero de choques) separando cada elemento do jogador por "_" e separanndo os jogadores por ";".
-- *** Por último vamos comprimir os disparos, para isso vamos comprimir cada elemento do disparo identificando antes de que disparo se trata. Tal como na compressão dos jogadores separamos os elementos dos disparos por "_" e separamos os disparos por ";".




testesT3 :: [Estado]
testesT3 = [t300,t301,t302,t303,t304,t305,t306,t307,t308,t309]

--  Teste 300 (Teste 00 da Tarefa 3)
t300 :: Estado
t300 = Estado (mapaInicial (10,10)) [Jogador (1,1) B 3 4 5,Jogador (3,1) C 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3]

--  Teste 301 (Teste 01 da Tarefa 3)
t301 :: Estado
t301 = Estado (mapaInicial (15,15)) [Jogador (12,7) C 0 4 5,Jogador (3,11) D 3 4 5,Jogador (1,10) D 3 4 5] [DisparoLaser 0 (10,5) D,DisparoChoque 1 3,DisparoChoque 0 3]

--  Teste 302 (Teste 02 da Tarefa 3)
t302 :: Estado
t302 = Estado (mapaInicial (6,6)) [] []

--  Teste 303 (Teste 03 da Tarefa 3)
t303 :: Estado
t303 = Estado (mapaInicial (6,6)) [Jogador (1,1) D 1 0 0,Jogador (1,3) D 1 0 0,Jogador (3,1) D 0 0 0,Jogador (3,3) D 1 0 0] []

--  Teste 304 (Teste 04 da Tarefa 3)
t304 :: Estado
t304 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (1,1) D 1 0 0,Jogador (4,7) D 1 0 0] [DisparoCanhao 0 (1,1) D]

--  Teste 305 (Teste 05 da Tarefa 3)
t305 :: Estado
t305 = Estado (mapaInicial (75,37)) [Jogador (64,7) C 2 43 51,Jogador (3,11) D 3 4 5,Jogador (51,30) D 3 4 5,Jogador (14,27) E 10 43 51,Jogador (66,11) B 99 4 52,Jogador (55,3) E 3 99 5] [DisparoLaser 0 (50,5) E,DisparoChoque 4 3,DisparoChoque 2 5,DisparoCanhao 3 (10,30) D]

--  Teste 306 (Teste 06 da Tarefa 3)
t306 :: Estado
t306 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [] [] 

--  Teste 307 (Teste 07 da Tarefa 3)
t307 :: Estado
t307 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (13,13) D 2 4 2,Jogador (5,9) E 100 253 523] []

--  Teste 308 (Teste 08 da Tarefa 3)
t308 :: Estado
t308 = Estado {mapaEstado = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]], jogadoresEstado = [Jogador {posicaoJogador = (2,1), direcaoJogador = B, vidasJogador = 99, lasersJogador = 45, choquesJogador = 99},Jogador {posicaoJogador = (10,3), direcaoJogador = E, vidasJogador = 2, lasersJogador = 2, choquesJogador = 0},Jogador {posicaoJogador = (4,21), direcaoJogador = B, vidasJogador = 1, lasersJogador = 0, choquesJogador = 4},Jogador {posicaoJogador = (10,18), direcaoJogador = E, vidasJogador = 42, lasersJogador = 8, choquesJogador = 0}], disparosEstado = [DisparoCanhao {jogadorDisparo = 2, posicaoDisparo = (4,21), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 2, posicaoDisparo = (5,21), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 2, posicaoDisparo = (6,21), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (3,1), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (10,7), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (10,8), direcaoDisparo = D}]}

--  Teste 309 (Teste 09 da Tarefa 3)
t309 :: Estado
t309 = Estado {mapaEstado = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]], jogadoresEstado = [Jogador {posicaoJogador = (1,1), direcaoJogador = D, vidasJogador = 5, lasersJogador = 0, choquesJogador = 1},Jogador {posicaoJogador = (2,64), direcaoJogador = E, vidasJogador = 5, lasersJogador = 0, choquesJogador = 0}], disparosEstado = [DisparoChoque {jogadorDisparo = 0, tempoDisparo = 2},DisparoChoque {jogadorDisparo = 1, tempoDisparo = 4},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,2), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,3), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,4), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,5), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,6), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,7), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,8), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,9), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,10), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,11), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,12), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,13), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,14), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,15), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,16), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,17), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,18), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,19), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,20), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,21), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,22), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,23), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,24), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,25), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,26), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,27), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,28), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,29), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,30), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,31), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,32), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,33), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,34), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,35), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,36), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,37), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,38), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,39), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,40), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,41), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,42), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,43), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,44), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,45), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,46), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,47), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,48), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,49), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,50), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,51), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,52), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,53), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,54), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,55), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,56), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,57), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,58), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,59), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,60), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,61), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,62), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,63), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,2), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,3), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,4), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,5), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,6), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,7), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,8), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,9), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,10), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,11), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,12), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,13), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,14), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,15), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,16), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,17), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,18), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,19), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,20), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,21), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,22), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,23), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,24), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,25), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,26), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,27), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,28), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,29), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,30), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,31), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,32), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,33), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,34), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,35), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,36), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,37), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,38), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,39), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,40), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,41), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,42), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,43), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,44), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,45), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,46), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,47), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,48), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,49), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,50), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,51), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,52), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,53), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,54), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,55), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,56), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,57), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,58), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,59), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,60), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,61), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,62), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,63), direcaoDisparo = E}]}

-- * Função principal da compressão.
-- | Função que comprime um 'Estado' para formato textual.
comprime :: Estado -- ^ O 'Estado' que será comprimido.
            -> String -- ^ A String resultante da compressão do 'Estado'
comprime (Estado m js ds) = comprimeMapa m ++ "#" ++ comprimeJogadores js ++ "#" ++ comprimeDisparos ds


{- | Função que dado uma lista de Peças dá uma String. -}
comprimeLista:: [Peca] -> String
comprimeLista [] = []
comprimeLista (p:ps) | p == Bloco Indestrutivel = "1" ++ comprimeLista ps 
                     | p == Bloco Destrutivel = "2" ++ comprimeLista ps 
                     | otherwise = "0" ++ comprimeLista ps


{- | Função que dada um lista de Peças verifica se são todas Bloco's Indestrutivei's. -}
linhaDeBlocos :: [Peca] -> Bool
linhaDeBlocos = foldr (\ x -> (&&) (x == Bloco Indestrutivel)) True


{- | Função que dado um inteiro dá uma lista de Peça's com o d Blocos Indestrutiveis. -}
constroiLinhaLimite :: Int -> [Peca]
constroiLinhaLimite 0 = []
constroiLinhaLimite d = Bloco Indestrutivel : constroiLinhaLimite (d-1)


{- | Função que dado um inteiro dá uma lista de Peça's com x elementos, sendo as bordas Blocos Indestrutiveis e o resto Vazia. -}
linhaComParede :: Int -> [Peca]
linhaComParede 0 = []
linhaComParede x = [Bloco Indestrutivel] ++ criaLinhaVazia (x-2) ++ [Bloco Indestrutivel]


{- | Função que cria uma coluna com Peças Vazia para depois ser usada para criar uma Matriz com as mesmas Peças. -}
criaLinhaVazia :: Int -> [Peca]
criaLinhaVazia 0 = []
criaLinhaVazia x = Vazia : criaLinhaVazia (x-1) 


{- | Função que dada uma lista de Peças calcula o numero de Blocos (destrutíveis ou indestrutíveis). -}
numeroBlocos :: [Peca] -> Int
numeroBlocos [] = 0
numeroBlocos (x:xs) = if x == Bloco Indestrutivel || x == Bloco Destrutivel
                      then 1 + numeroBlocos xs
                      else numeroBlocos xs        


{- | Função que dado um Mapa dá uma String, que corresponde ao mapa comprimido. -}
comprimeMapa:: [[Peca]] -> String
comprimeMapa [] = []
comprimeMapa (p:ps) | linhaDeBlocos p = [chr (length p)] ++ "," ++ comprimeMapa ps
                    | numeroBlocos p == 2 = "!" ++ [chr (length p)] ++ "," ++ comprimeMapa ps
                    | otherwise = comprimeLista p ++ "," ++ comprimeMapa ps



{- | Função que dado um Jogadordá uma String com os Jogadore comprimido. -}
comprimeJog :: Jogador -> String
comprimeJog (Jogador (x,y) d v l c) = show x  ++ "_" ++ show y ++ "_" ++ show d  ++ "_" ++ show v ++ "_" ++ show l  ++ "_" ++ show c 


{- | Função que dado uma lista de Jogadores dá uma String com os jogadores comprimidos. -}
comprimeJogadores :: [Jogador] -> String
comprimeJogadores [] = []
comprimeJogadores (Jogador (x,y) d v l c:js) = comprimeJog (Jogador (x,y) d v l c) ++ ";" ++ comprimeJogadores js


{- | Função que dado um Disparo dá uma String com o disparo comprimido. -}
comprimeDis :: Disparo -> String
comprimeDis (DisparoCanhao i (x,y) d) = "b" ++ "_" ++ show i ++ "_" ++ show x  ++ "_" ++ show y ++ "_" ++ show d
comprimeDis (DisparoLaser i (x,y) d) = "l" ++ "_" ++ show i ++ "_" ++ show x  ++ "_" ++ show y ++ "_" ++ show d
comprimeDis (DisparoChoque i t) = "c" ++ "_" ++ show i ++ "_" ++ show t


{- | Função que dado uma lista de Disparos dá uma String com os Disparos comprimidos. -}
comprimeDisparos :: [Disparo] -> String
comprimeDisparos [] = []
comprimeDisparos (d:ds) = comprimeDis d ++ ";" ++ comprimeDisparos ds 


-- * Objetivos da descompressão

-- *** Nesta parte da tarefa, tal como na compressão, optamos por descomprimir tudo por partes. Para separar o mapa, os jogadores e os disparos dividimos a string recebida no símbolo '#'. Agora temos 3 strings novas, a primeira que corresponde ao mapa, a segunda aos jogadores e a terceira aos disparos.
-- *** Primeiramente começamos por descomprimir o mapa, sendo que cada vez que aparece ',' sabemos que acabou uma linha e que de seguida vem outra. Descomprimimos linha por linha até termos o mapa completo.
-- *** De seguida vamos para a lista de jogadores. Separando então a string recebida em múltiplas strings (separando cada vez que aparece ';') iremos separa então a primeira string novamente em múltiplas strings, sendo que agora cada string corresponde a um elemento do jogador (x,y) direção lasers vidas e choques, fazendo um 'read' de cada elemento obtemos o jogador e as suas características podendo passar agora para o jogador seguinte.
-- *** Da mesma maneira que descomprimimos os jogadores iremos descomprimir agora os disparos.

-- * Função principal da descompressão.

-- | Descomprime um 'Estado' no formato textual utilizado pela função 'comprime'.
descomprime :: String -- ^ String que será descomprimida.
               -> Estado -- ^ 'Estado' resultante da descompressão da string recebida.
descomprime x = descomprimeAux (splitOn "#" x)


{- | Função auxiliar da função Descomprime sendo que nesta recebe uma lista de string's dando o Estado descomprimido. -}
descomprimeAux :: [String] -> Estado
descomprimeAux (x:y:z:xs) = Estado (descomprimeMapa (splitOn "," x)) (descomprimeJogadores (splitOn ";" y)) (descomprimeDisparos (splitOn ";" z))




{- | Função que dada uma String dá a lista de Peças correspondente. -}
descomprimeLista :: String -> [Peca]
descomprimeLista [] = []
descomprimeLista (x:xs) | x == '0' = Vazia : descomprimeLista xs
                        | x == '1' = Bloco Indestrutivel : descomprimeLista xs
                        | x == '2' = Bloco Destrutivel : descomprimeLista xs
                        | x == '!' = linhaComParede (ord(head xs)) 
                        | otherwise = constroiLinhaLimite (ord x) 


{- | Função que dada uma lista de String dá o Mapa correspondente. -}
descomprimeMapa :: [String] -> [[Peca]]
descomprimeMapa [""] = []
descomprimeMapa [] = []
descomprimeMapa (l:ls) = descomprimeLista l : descomprimeMapa ls


{- | Função que dada uma String dá o Jogador correspondente. -}
descomprimeJogador :: String -> Jogador
descomprimeJogador js = Jogador (x,y) d v l c
                   where x = read (encontraIndiceLista 0 (splitOn "_" js))
                         y = read (encontraIndiceLista 1 (splitOn "_" js))
                         d = read (encontraIndiceLista 2 (splitOn "_" js))
                         v = read (encontraIndiceLista 3 (splitOn "_" js))
                         l = read (encontraIndiceLista 4 (splitOn "_" js))
                         c = read (encontraIndiceLista 5 (splitOn "_" js))


{- | Função que dada uma lista de String dá a lista de Jogadores correspondente. -}
descomprimeJogadores :: [String] -> [Jogador]
descomprimeJogadores [] = []
descomprimeJogadores [""] = []
descomprimeJogadores (j:js) = descomprimeJogador j : descomprimeJogadores (eliminaListaStr 0 js)


{- | Função que dada uma String dá o Disparo correspondente. -}
descomprimeDisparo :: [String] -> Disparo 
descomprimeDisparo (m : ms) | m == "b" = DisparoCanhao i (x, y) d
                            | m == "l" = DisparoLaser i (x, y) d
                            | otherwise = DisparoChoque i t
                         where i = read (encontraIndiceLista 0 ms)
                               x = read (encontraIndiceLista 1 ms)
                               y = read (encontraIndiceLista 2 ms)
                               d = read (encontraIndiceLista 3 ms)
                               t = read (last ms)


{- | Função que dada uma lista de Strings devolve uma lista de Disparos. -}
descomprimeDisparos:: [String] -> [Disparo]
descomprimeDisparos [] = []
descomprimeDisparos [""] = []
descomprimeDisparos (x:xs) = descomprimeDisparo (splitOn "_" x) : descomprimeDisparos (eliminaListaStr 0 xs)


{- | Função que dado um inteiro e uma lista de String's elimina as primeira (i) listas. -}
eliminaListaStr :: Int -> [String] -> [String]
eliminaListaStr i [] = []
eliminaListaStr 0 l = l
eliminaListaStr i (x:xs) = if i == 1 
                           then xs
                           else eliminaListaStr (i-1) xs

-- *** Conclusão

-- *** Embora tenha sido fácil de perceber como fazer a compressão, inicialmente tívemos dificuldades em conseguir descomprimir a String comprimida anteriormente. Optamos então por separar cada elemento dos jogadores e dos disparas por símbolos para depois ser mais fácil de descomprimir separando todos os elementos. Com isto a compressão será sempre menor porque ainda usamos bastantes símbolos uma vez que os jogadores têm 6 elementos distintos e os disparos podem ter 2 ou 4. Mesmo assim conseguimos uma compressão superior a 90% que era o nosso principal objetivo tendo em conta as dificuldades iniciais. 

