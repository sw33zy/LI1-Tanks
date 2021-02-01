{-|
Module      : Tarefa4_2018li1g141
Description : Modulo que define a passagem de um Tick.
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;
O objectivo desta tarefa é, dada um estado, determinar o efeito de um tick, dando o estado resultante.
-}


module Tarefa4_2018li1g141 where

import LI11819
import Tarefa0_2018li1g141
import Tarefa1_2018li1g141
import Tarefa2_2018li1g141
import Data.List

{- | Testes unitários da Tarefa 4.
Cada teste é um 'Estado'. -}
testesT4 :: [Estado]
testesT4 = [t401,t402,t403,t404,t405,t406,t407,t408,t409,t410,t411,t412,t413,t414,t415,t416,t417,t418,t419,t420,t421,t422,t423,t424,t425,t426,t427,t428,t429,t430,t431,t431,t432,t433,t434,t435,t436,t437,t438,t439,t440,t441,t442,t443,t444,t445,t446,t447,t448,t300,t301,t302,t303,t304,t305,t306,t307,t308,t309]

-- | Teste 401 (Teste 01 da Tarefa 4) 
t401 = Estado (mapaInicial (15,15)) [Jogador (12,7) C 2 4 5,Jogador (3,11) D 3 4 5,Jogador (1,10) D 3 4 5] [DisparoCanhao 0 (10,5) D,DisparoCanhao 1 (7,7) C,DisparoCanhao 2 (11,6) D]

-- | Teste 402 (Teste 02 da Tarefa 4) 
t402 = Estado (mapaInicial (10,10)) [Jogador (1,6) E 10 41 28,Jogador (1,1) D 22 21 0,Jogador (3,4) C 22 21 20] [DisparoCanhao 0 (1,4) E,DisparoCanhao 2 (1,4) C,DisparoCanhao 0 (1,4) D]

-- | Teste 403 (Teste 03 da Tarefa 4) 
t403 = Estado (mapaInicial (15,15)) [Jogador (12,7) C 2 4 5,Jogador (3,11) D 3 4 5,Jogador (1,10) D 3 4 5] [DisparoCanhao 0 (1,12) E,DisparoCanhao 0 (1,3) D,DisparoCanhao 1 (1,5) E,DisparoLaser 0 (8,1) E,DisparoChoque 1 4]

-- | Teste 404 (Teste 04 da Tarefa 4) 
t404 = Estado (mapaInicial (10,10)) [Jogador (1,1) B 3 4 5,Jogador (2,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoLaser 2 (6,2) D,DisparoLaser 0 (2,1) B]

-- | Teste 405 (Teste 05 da Tarefa 4) 
t405 = Estado (mapaInicial (10,10)) [Jogador (1,1) D 3 4 5,Jogador (2,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoChoque 1 4,DisparoChoque 0 4]

-- | Teste 406 (Teste 06 da Tarefa 4) 
t406 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (2,3) B 2 4 5,Jogador (6,1) D 3 4 5] [DisparoLaser 0 (3,3) B,DisparoLaser 1 (6,2) D]

-- | Teste 407 (Teste 07 da Tarefa 4) 
t407 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (2,3) B 2 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (3,3) B,DisparoLaser 1 (6,2) D]

-- | Teste 408 (Teste 08 da Tarefa 4) 
t408 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (2,3) B 2 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (3,3) B,DisparoCanhao 1 (6,2) D]

-- | Teste 409 (Teste 09 da Tarefa 4) 
t409 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (2,3) B 2 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (3,3) B,DisparoLaser 1 (6,2) D,DisparoChoque 0 4,DisparoChoque  1 2]

-- | Teste 410 (Teste 10 da Tarefa 4) 
t410 = Estado (mapaInicial(10,10)) [Jogador (1,1) D 3 4 5,Jogador (1,6) B 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (1,5) D,DisparoCanhao 1 (3,6) B,DisparoCanhao 2 (6,3) D]

-- | Teste 411 (Teste 11 da Tarefa 4) 
t411 = Estado (mapaInicial(10,10)) [Jogador (1,1) D 3 4 5,Jogador (1,6) B 3 4 5,Jogador (6,1) D 3 4 5] [DisparoLaser 0 (1,2) D,DisparoLaser 1 (2,6) B,DisparoChoque 2 3] 

-- | Teste 412 (Teste 12 da Tarefa 4) 
t412 = Estado (mapaInicial(10,10)) [Jogador (1,1) D 3 4 5,Jogador (1,6) B 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (1,2) D,DisparoLaser 1 (2,6) B,DisparoLaser 2 (6,2) D]

-- | Teste 413 (Teste 13 da Tarefa 4) 
t413 = Estado (mapaInicial(10,10)) [Jogador (1,7) D 3 4 5,Jogador (3,6) B 3 4 5,Jogador (2,1) D 3 4 5] [DisparoLaser 2 (2,2) B,DisparoCanhao 2 (2,5) D]

-- | Teste 414 (Teste 14 da Tarefa 4) 
t414 = Estado (mapaInicial (10,10)) [Jogador (1,1) D 3 4 5,Jogador (2,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoLaser 2 (3,2) B,DisparoCanhao 2 (2,4) E]

-- | Teste 415 (Teste 15 da Tarefa 4) 
t415 = Estado (mapaInicial (10,10)) [Jogador (1,1) D 3 4 5] [DisparoLaser 0 (1,2) D,DisparoCanhao 0 (1,5) D]

-- | Teste 416 (Teste 16 da Tarefa 4) 
t416 = Estado (mapaInicial (10,10)) [Jogador (1,6) E 10 41 28,Jogador (1,1) D 22 21 0,Jogador (3,4) C 22 21 20] [DisparoCanhao 0 (1,4) E,DisparoCanhao 2 (1,4) C,DisparoCanhao 0 (1,4) D,DisparoCanhao 0 (1,4) B] 

-- | Teste 417 (Teste 17 da Tarefa 4) 
t417 = Estado (mapaInicial (10,10)) [Jogador (1,6) E 10 41 28,Jogador (1,1) D 22 21 0,Jogador (3,4) C 22 21 20] [DisparoCanhao 0 (1,5) E,DisparoCanhao 1 (1,3) D,DisparoCanhao 2 (2,4) C] 

-- | Teste 418 (Teste 18 da Tarefa 4) 
t418 = Estado (mapaInicial (10,10)) [Jogador (1,6) E 10 41 28,Jogador (1,1) D 22 21 0,Jogador (3,4) C 22 21 20] [DisparoLaser 0 (1,7) E,DisparoCanhao 1 (1,3) D,DisparoCanhao 2 (2,4) C]  

-- | Teste 419 (Teste 19 da Tarefa 4) 
t419 = Estado (mapaInicial (10,10)) [Jogador (1,6) E 10 41 28,Jogador (1,1) D 22 21 0,Jogador (3,4) C 22 21 20] [DisparoCanhao 0 (1,4) E,DisparoCanhao 2 (1,4) C] 

-- | Teste 420 (Teste 20 da Tarefa 4) 
t420 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (7,1) D 22 21 0] [DisparoCanhao 0 (1,4) E,DisparoLaser 0 (6,4) E] 

-- | Teste 421 (Teste 21 da Tarefa 4) 
t421 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (6,1) D 22 21 0] [DisparoCanhao 0 (1,3) E,DisparoLaser 0 (7,4) E] 

-- | Teste 422 (Teste 22 da Tarefa 4) 
t422 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (6,1) D 22 21 0] [DisparoCanhao 0 (3,3) E,DisparoCanhao 0 (7,2) C] 

-- | Teste 423 (Teste 23 da Tarefa 4) 
t423 = Estado (mapaInicial (10,10)) [Jogador (4,2) E 10 41 28,Jogador (6,3) D 22 21 0] [DisparoCanhao 0 (3,3) E,DisparoCanhao 0 (7,2) C] 

-- | Teste 424 (Teste 24 da Tarefa 4) 
t424 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (6,1) D 22 21 0] [DisparoCanhao 0 (3,1) D,DisparoCanhao 0 (5,2) B] 

-- | Teste 425 (Teste 25 da Tarefa 4) 
t425 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (6,1) D 22 21 0] [DisparoLaser 0 (3,1) D,DisparoLaser 0 (5,2) B] 

-- | Teste 426 (Teste 26 da Tarefa 4) 
t426 = Estado (mapaInicial (10,10)) [Jogador (2,3) B 7 41 28,Jogador (1,7) E 4 3 3] [DisparoLaser 1 (1,6) E,DisparoLaser 0 (2,4) D]  
--(DisparoLaser 1 (1,6) E)
-- | Teste 427 (Teste 27 da Tarefa 4) 
t427 = Estado (mapaInicial (10,10)) [Jogador (5,2) E 10 41 28,Jogador (7,2) D 22 21 0] [DisparoCanhao 1 (6,1) D] 

-- | Teste 428 (Teste 28 da Tarefa 4) 
t428 = Estado (mapaInicial (10,10)) [Jogador (6,2) E 10 41 28,Jogador (6,4) D 22 21 0] [DisparoCanhao 1 (5,3) B] 

-- | Teste 429 (Teste 29 da Tarefa 4) 
t429 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (2,4) D 22 21 0] [DisparoCanhao 1 (1,3) B] 

-- | Teste 430 (Teste 30 da Tarefa 4) 
t430 = Estado (mapaInicial (10,10)) [Jogador (5,2) E 10 41 28,Jogador (7,2) D 22 21 0] [DisparoCanhao 1 (6,3) E] 

-- | Teste 431 (Teste 31 da Tarefa 4)
t431 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (1,1) D 5 0 1,Jogador (2,64) E 5 0 0] [DisparoChoque 0 2,DisparoChoque 1 4,DisparoCanhao 0 (1,2) D,DisparoCanhao 0 (1,3) D,DisparoCanhao 0 (1,4) D,DisparoCanhao 0 (1,5) D,DisparoCanhao 0 (1,6) D,DisparoCanhao 0 (1,7) D,DisparoCanhao 0 (1,8) D,DisparoCanhao 0 (1,9) D,DisparoCanhao 0 (1,10) D,DisparoCanhao 0 (1,11) D,DisparoCanhao 0 (1,12) D,DisparoCanhao 0 (1,13) D,DisparoCanhao 0 (1,14) D,DisparoCanhao 0 (1,15) D,DisparoCanhao 0 (1,16) D,DisparoCanhao 0 (1,17) D,DisparoCanhao 0 (1,18) D,DisparoCanhao 0 (1,19) D,DisparoCanhao 0 (1,20) D,DisparoCanhao 0 (1,21) D,DisparoCanhao 0 (1,22) D,DisparoCanhao 0 (1,23) D,DisparoCanhao 0 (1,24) D,DisparoCanhao 0 (1,25) D,DisparoCanhao 0 (1,26) D,DisparoCanhao 0 (1,27) D,DisparoCanhao 0 (1,28) D,DisparoCanhao 0 (1,29) D,DisparoCanhao 0 (1,30) D,DisparoCanhao 0 (1,31) D,DisparoCanhao 0 (1,32) D,DisparoCanhao 0 (1,33) D,DisparoCanhao 0 (1,34) D,DisparoCanhao 0 (1,35) D,DisparoCanhao 0 (1,36) D,DisparoCanhao 0 (1,37) D,DisparoCanhao 0 (1,38) D,DisparoCanhao 0 (1,39) D,DisparoCanhao 0 (1,40) D,DisparoCanhao 0 (1,41) D,DisparoCanhao 0 (1,42) D,DisparoCanhao 0 (1,43) D,DisparoCanhao 0 (1,44) D,DisparoCanhao 0 (1,45) D,DisparoCanhao 0 (1,46) D,DisparoCanhao 0 (1,47) D,DisparoCanhao  0 (1,48) D,DisparoCanhao 0 (1,49) D,DisparoCanhao 0 (1,50) D,DisparoCanhao 0 (1,51) D,DisparoCanhao 0 (1,52) D,DisparoCanhao 0 (1,53) D,DisparoCanhao 0 (1,54) D,DisparoCanhao 0 (1,55) D,DisparoCanhao 0 (1,56) D,DisparoCanhao 0 (1,57) D,DisparoCanhao 0 (1,58) D,DisparoCanhao 0 (1,59) D,DisparoCanhao 0 (1,60) D,DisparoCanhao 0 (1,61) D,DisparoCanhao 0 (1,62) D,DisparoCanhao 0 (1,63) D,DisparoCanhao 1 (2,2) E,DisparoCanhao 1 (2,3) E,DisparoCanhao 1 (2,4) E,DisparoCanhao 1 (2,5) E,DisparoCanhao 1 (2,6) E,DisparoCanhao 1 (2,7) E,DisparoCanhao 1 (2,8) E,DisparoCanhao 1 (2,9) E,DisparoCanhao 1 (2,10) E,DisparoCanhao 1 (2,11) E,DisparoCanhao 1 (2,12) E,DisparoCanhao 1 (2,13) E,DisparoCanhao 1 (2,14) E,DisparoCanhao 1 (2,15) E,DisparoCanhao 1 (2,16) E,DisparoCanhao 1 (2,17) E,DisparoCanhao 1 (2,18) E,DisparoCanhao 1 (2,19) E,DisparoCanhao 1 (2,20) E,DisparoCanhao 1 (2,21) E,DisparoCanhao 1 (2,22) E,DisparoCanhao 1 (2,23) E,DisparoCanhao 1 (2,24) E,DisparoCanhao 1 (2,25) E,DisparoCanhao 1 (2,26) E,DisparoCanhao 1 (2,27) E,DisparoCanhao 1 (2,28) E,DisparoCanhao 1 (2,29) E,DisparoCanhao 1 (2,30) E,DisparoCanhao 1 (2,31) E,DisparoCanhao 1 (2,32) E,DisparoCanhao 1 (2,33) E,DisparoCanhao 1 (2,34) E,DisparoCanhao 1 (2,35) E,DisparoCanhao 1 (2,36) E,DisparoCanhao 1 (2,37) E,DisparoCanhao 1 (2,38) E,DisparoCanhao 1 (2,39) E,DisparoCanhao 1 (2,40) E,DisparoCanhao 1 (2,41) E,DisparoCanhao 1 (2,42) E,DisparoCanhao 1 (2,43) E,DisparoCanhao 1 (2,44) E,DisparoCanhao 1 (2,45) E,DisparoCanhao 1 (2,46) E,DisparoCanhao 1 (2,47) E,DisparoCanhao 1 (2,48) E,DisparoCanhao 1 (2,49) E,DisparoCanhao 1 (2,50) E,DisparoCanhao 1 (2,51) E,DisparoCanhao 1 (2,52) E,DisparoCanhao 1 (2,53) E,DisparoCanhao 1 (2,54) E,DisparoCanhao 1 (2,55) E,DisparoCanhao 1 (2,56) E,DisparoCanhao 1 (2,57) E,DisparoCanhao 1 (2,58) E,DisparoCanhao 1 (2,59) E,DisparoCanhao 1 (2,60) E,DisparoCanhao 1 (2,61) E,DisparoCanhao 1 (2,62) E,DisparoCanhao 1 (2,63) E]

-- | Teste 432 (Teste 32 da Tarefa 4) 
t432 = Estado (mapaInicial (10,10)) [Jogador (5,2) E 10 41 28,Jogador (7,2) D 22 21 0] [DisparoLaser 1 (6,1) D] 

-- | Teste 433 (Teste 33 da Tarefa 4) 
t433 = Estado (mapaInicial (10,10)) [Jogador (6,2) E 10 41 28,Jogador (6,4) D 22 21 0] [DisparoLaser 1 (5,3) B]

-- | Teste 434 (Teste 34 da Tarefa 4) 
t434 = Estado (mapaInicial (10,10)) [Jogador (2,2) E 10 41 28,Jogador (2,4) D 22 21 0] [DisparoLaser 1 (1,3) B] 

-- | Teste 435 (Teste 35 da Tarefa 4) 
t435 = Estado (mapaInicial (10,10)) [Jogador (5,2) E 10 41 28,Jogador (7,2) D 22 21 0] [DisparoLaser 1 (6,3) E]

-- | Teste 436 (Teste 36 da Tarefa 4) 
t436 = Estado (mapaInicial (10,10)) [Jogador (5,2) E 10 41 28] [DisparoLaser 0 (6,3) E] 

-- | Teste 437 (Teste 37 da Tarefa 4) 
t437 = Estado (mapaInicial (10,10)) [Jogador (5,2) E 1 41 28] [DisparoLaser 0 (1,1) D,DisparoCanhao 0 (1,2) D,DisparoCanhao 0 (1,4) E,DisparoCanhao 0 (1,6) D,DisparoCanhao 0 (1,7) E]

-- | Teste 438 (Teste 38 da Tarefa 4) 
t438 = Estado (mapaInicial (10,10)) [Jogador (1,5) E 2 41 28] [DisparoLaser 0 (1,1) D,DisparoLaser 0 (5,5) C,DisparoLaser 0 (3,5) C,DisparoLaser 0 (4,5) C] 

-- | Teste 439 (Teste 39 da Tarefa 4) 
t439 = Estado (mapaInicial (10,10)) [Jogador (2,3) B 7 41 28,Jogador (7,3) C 2 4 4,Jogador (1,7) E 4 3 3] [DisparoLaser 2 (1,6) E,DisparoLaser 0 (2,4) D,DisparoLaser 1 (6,3) C] 

-- | Teste 440 (Teste 40 da Tarefa 4)
t440 = Estado (mapaInicial (10,10)) [Jogador (2,3) B 7 41 28,Jogador (7,3) C 2 4 4,Jogador (1,7) E 4 3 3] [DisparoLaser 2 (1,6) E,DisparoLaser 0 (2,4) D]

-- | Teste 441 (Teste 41 da Tarefa 4)
t441 = Estado (mapaInicial (10,10)) [Jogador (2,3) B 7 41 28] [DisparoLaser 0 (1,2) E,DisparoLaser 0 (6,2) E] 

-- | Teste 442 (Teste 42 da Tarefa 4) 
t442 = Estado (mapaInicial (10,10)) [Jogador (1,3) E 10 41 28,Jogador (1,1) D 22 21 0,Jogador (3,4) C 22 21 20] [DisparoLaser 0 (1,7) E]  

-- | Teste 443 (Teste 43 da Tarefa 4) 
t443 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (4,8) E 5 5 5,Jogador (5,4) C 5 5 5] [DisparoLaser 0 (4,7) E,DisparoLaser 1 (4,4) C] 

-- | Teste 444 (Teste 44 da Tarefa 4) 
t444 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (4,8) E 5 5 5,Jogador (5,4) C 5 5 5] [DisparoLaser 0 (4,7) E] 

-- | Teste 445 (Teste 45 da Tarefa 4) 
t445 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (4,8) E 5 5 5,Jogador (5,4) C 5 5 5] [DisparoLaser 1 (4,4) C]

-- | Teste 446 (Teste 46 da Tarefa 4) 
t446 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (4,8) E 5 5 5,Jogador (4,10) E 5 5 5] [DisparoLaser 0 (4,7) E,DisparoLaser 1 (4,9) E] 

-- | Teste 447 (Teste 47 da Tarefa 4) 
t447 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (4,8) E 5 5 5,Jogador (5,4) C 5 5 5] [DisparoLaser 0 (4,7) E] 

-- | Teste 448 (Teste 48 da Tarefa 4)
t448 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (3,5) E 5 5 5] [DisparoCanhao 0 (3,4) E,DisparoCanhao 0 (3,3) E]

-- | Teste 300 (Teste 00 da Tarefa 3)
t300 :: Estado
t300 = Estado (mapaInicial (10,10)) [Jogador (1,1) B 3 4 5,Jogador (3,1) C 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3]

-- | Teste 301 (Teste 01 da Tarefa 3)
t301 :: Estado
t301 = Estado (mapaInicial (15,15)) [Jogador (12,7) C 0 4 5,Jogador (3,11) D 3 4 5,Jogador (1,10) D 3 4 5] [DisparoLaser 0 (10,5) D,DisparoChoque 1 3,DisparoChoque 0 3]

-- | Teste 302 (Teste 02 da Tarefa 3)
t302 :: Estado
t302 = Estado (mapaInicial (6,6)) [] []

-- | Teste 303 (Teste 03 da Tarefa 3)
t303 :: Estado
t303 = Estado (mapaInicial (6,6)) [Jogador (1,1) D 1 0 0,Jogador (1,3) D 1 0 0,Jogador (3,1) D 0 0 0,Jogador (3,3) D 1 0 0] []

-- | Teste 304 (Teste 04 da Tarefa 3)
t304 :: Estado
t304 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (1,1) D 1 0 0,Jogador (4,7) D 1 0 0] [DisparoCanhao 0 (1,1) D]

-- | Teste 305 (Teste 05 da Tarefa 3)
t305 :: Estado
t305 = Estado (mapaInicial (75,37)) [Jogador (64,7) C 2 43 51,Jogador (3,11) D 3 4 5,Jogador (51,30) D 3 4 5,Jogador (14,27) E 10 43 51,Jogador (66,11) B 99 4 52,Jogador (55,3) E 3 99 5] [DisparoLaser 0 (50,5) E,DisparoChoque 4 3,DisparoChoque 2 5,DisparoCanhao 3 (10,30) D]

-- | Teste 306 (Teste 06 da Tarefa 3)
t306 :: Estado
t306 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Vazia,Vazia,Bloco Destrutivel,Vazia,Bloco Destrutivel,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (4,8) E 5 5 5,Jogador (5,4) C 5 5 5] [DisparoCanhao 0 (4,7) E,DisparoCanhao 1 (4,4) C] 

-- | Teste 307 (Teste 07 da Tarefa 3)
t307 :: Estado
t307 = Estado [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]] [Jogador (13,13) D 2 4 2,Jogador (5,9) E 100 253 523] []

-- | Teste 308 (Teste 08 da Tarefa 3)
t308 :: Estado
t308 = Estado {mapaEstado = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Destrutivel,Bloco Destrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]], jogadoresEstado = [Jogador {posicaoJogador = (2,1), direcaoJogador = B, vidasJogador = 99, lasersJogador = 45, choquesJogador = 99},Jogador {posicaoJogador = (10,3), direcaoJogador = E, vidasJogador = 2, lasersJogador = 2, choquesJogador = 0},Jogador {posicaoJogador = (4,21), direcaoJogador = B, vidasJogador = 1, lasersJogador = 0, choquesJogador = 4},Jogador {posicaoJogador = (10,18), direcaoJogador = E, vidasJogador = 42, lasersJogador = 8, choquesJogador = 0}], disparosEstado = [DisparoCanhao {jogadorDisparo = 2, posicaoDisparo = (4,21), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 2, posicaoDisparo = (5,21), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 2, posicaoDisparo = (6,21), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (3,1), direcaoDisparo = B},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (10,7), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (10,8), direcaoDisparo = D}]}

-- | Teste 309 (Teste 09 da Tarefa 3)
t309 :: Estado
t309 = Estado {mapaEstado = [[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Vazia,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]], jogadoresEstado = [Jogador {posicaoJogador = (1,1), direcaoJogador = D, vidasJogador = 5, lasersJogador = 0, choquesJogador = 1},Jogador {posicaoJogador = (2,64), direcaoJogador = E, vidasJogador = 5, lasersJogador = 0, choquesJogador = 0}], disparosEstado = [DisparoChoque {jogadorDisparo = 0, tempoDisparo = 2},DisparoChoque {jogadorDisparo = 1, tempoDisparo = 4},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,2), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,3), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,4), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,5), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,6), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,7), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,8), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,9), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,10), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,11), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,12), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,13), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,14), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,15), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,16), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,17), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,18), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,19), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,20), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,21), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,22), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,23), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,24), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,25), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,26), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,27), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,28), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,29), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,30), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,31), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,32), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,33), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,34), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,35), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,36), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,37), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,38), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,39), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,40), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,41), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,42), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,43), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,44), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,45), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,46), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,47), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,48), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,49), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,50), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,51), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,52), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,53), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,54), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,55), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,56), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,57), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,58), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,59), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,60), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,61), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,62), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 0, posicaoDisparo = (1,63), direcaoDisparo = D},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,2), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,3), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,4), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,5), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,6), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,7), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,8), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,9), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,10), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,11), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,12), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,13), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,14), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,15), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,16), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,17), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,18), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,19), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,20), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,21), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,22), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,23), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,24), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,25), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,26), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,27), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,28), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,29), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,30), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,31), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,32), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,33), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,34), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,35), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,36), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,37), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,38), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,39), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,40), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,41), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,42), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,43), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,44), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,45), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,46), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,47), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,48), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,49), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,50), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,51), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,52), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,53), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,54), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,55), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,56), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,57), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,58), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,59), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,60), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,61), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,62), direcaoDisparo = E},DisparoCanhao {jogadorDisparo = 1, posicaoDisparo = (2,63), direcaoDisparo = E}]}



-- * Funções principais da Tarefa 4.

{- | Avança o 'Estado' do jogo um 'Tick' de tempo. -}
tick :: Estado -> Estado 
tick = tickChoques . tickCanhoes . tickLasers


{- | Avança o 'Estado' do jogo um 'Tick' de tempo, considerando apenas os efeitos dos tiros de 'Laser' disparados. -}
tickLasers :: Estado -> Estado
tickLasers (Estado m js ds) = Estado (disparosLasers (Estado m js (soLasers ds))) (listaFinalJog (tiraVidaAposLaser (jogAtingidosLasers (Estado m js (soLasers ds)))js)) (eliminaBalasAposLasers (unicaPosPassaLaser (Estado m js ds))(eliminaLasers (Estado m js ds)))


{- | Dado um Estado dá lista de Disparos deste mas sem os Disparos de Lasers. -}
eliminaLasers :: Estado -> [Disparo]
eliminaLasers (Estado m js []) = []
eliminaLasers (Estado m js (DisparoLaser i p d:ds)) = eliminaLasers (Estado m js ds)
eliminaLasers (Estado m js (DisparoCanhao i p d:ds)) = DisparoCanhao i p d : eliminaLasers (Estado m js ds)
eliminaLasers (Estado m js (DisparoChoque i t:ds)) = DisparoChoque i t : eliminaLasers (Estado m js ds)

{- | Recebe uma lista de Disparos e retorna apenas os Disparos de Lasers. -}
soLasers :: [Disparo] -> [Disparo]
soLasers [] = []
soLasers (DisparoLaser i p d:ds) = DisparoLaser i p d : soLasers ds
soLasers (DisparoCanhao i p d:ds) = soLasers ds
soLasers (DisparoChoque i t:ds) = soLasers ds


{- | Recebe uma lista de Disparos e retorna apenas os Disparos de Canhões. -}
soCanhoes :: [Disparo] -> [Disparo]
soCanhoes [] = []
soCanhoes (DisparoCanhao i p d:ds) = DisparoCanhao i p d : soCanhoes ds
soCanhoes (DisparoLaser i p d:ds) = soCanhoes ds 
soCanhoes (DisparoChoque i t:ds) = soCanhoes ds


{- | Dado um Estado, dá o Mapa resultante após um 'Tick' de tempo. -}
disparosLasers :: Estado -> Mapa
disparosLasers (Estado m js []) = m
disparosLasers (Estado m js (DisparoLaser i p d:ds)) | esqOuCima && encontraPosicaoMatriz p m == Bloco Indestrutivel && encontraPosicaoMatriz (segPosBala p d) m == Bloco Indestrutivel = disparosLasers (Estado m js ds)
                                                     | esqOuCima && encontraPosicaoMatriz p m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosBala p d) m /= Bloco Indestrutivel = disparosLasers (Estado (atualizaPosicaoMatriz p Vazia (atualizaPosicaoMatriz (segPosBala p d) Vazia m)) js (DisparoLaser i (posSeg p d) d:ds))
                                                     | esqOuCima && encontraPosicaoMatriz p m == Bloco Indestrutivel && encontraPosicaoMatriz (segPosBala p d) m /= Bloco Indestrutivel = disparosLasers (Estado (atualizaPosicaoMatriz (segPosBala p d) Vazia m) js ds)
                                                     | esqOuCima && encontraPosicaoMatriz p m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosBala p d) m == Bloco Indestrutivel = disparosLasers (Estado (atualizaPosicaoMatriz p Vazia m) js ds)
                                                     | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Indestrutivel = disparosLasers (Estado m js ds)
                                                     | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Destrutivel = disparosLasers (Estado (atualizaPosicaoMatriz (segPosSeg p d) Vazia m) js ds)
                                                     | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Vazia = disparosLasers (Estado m js ds)
                                                     | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Bloco Indestrutivel = disparosLasers (Estado (atualizaPosicaoMatriz (posSeg p d) Vazia m) js ds)
                                                     | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Bloco Destrutivel = disparosLasers (Estado (atualizaPosicaoMatriz (posSeg p d) Vazia (atualizaPosicaoMatriz (segPosSeg p d) Vazia m)) js (DisparoLaser i (posSeg p d) d:ds))
                                                     | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Vazia = disparosLasers (Estado (atualizaPosicaoMatriz (posSeg p d) Vazia m) js (DisparoLaser i (posSeg p d) d:ds))
                                                     | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Indestrutivel = disparosLasers (Estado m js ds)
                                                     | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Destrutivel = disparosLasers (Estado (atualizaPosicaoMatriz (segPosSeg p d) Vazia m) js (DisparoLaser i (posSeg p d) d:ds))
                                                     | posicaoSeguinte == Vazia && segPosicaoSeguinte == Vazia = disparosLasers (Estado m js (DisparoLaser i (posSeg p d) d:ds))                                                             
                                     where posicaoSeguinte = encontraPosicaoMatriz (posSeg p d) m
                                           segPosicaoSeguinte = encontraPosicaoMatriz (segPosSeg p d) m
                                           esqOuCima = d == E || d == C

{- | Recebendo uma lista de inteiros, correspondente ao indice dos Jogadores que foram atingidos por um Laser, e uma lista de Jogadores, esta função retorna a lista de Jogadores com as vidas deles atualizadas. -}
tiraVidaAposLaser :: [Int] -> [Jogador] -> [Jogador]
tiraVidaAposLaser [] js = js
tiraVidaAposLaser (i:is) [] = []
tiraVidaAposLaser (i:is) js = tiraVidaAposLaser is (tiraVidaAposLaseraux i js) 

{- | Função auxiliar à função 'tiraVidaAposLaser', neste caso apenas consideramos um Inteiro, atualizando as vidas a apenas um Jogador da lista de Jogadores. -}
tiraVidaAposLaseraux :: Int -> [Jogador] -> [Jogador]
tiraVidaAposLaseraux i [] = []
tiraVidaAposLaseraux i (Jogador p d v l c:js) = if i == 0 
                                                      then Jogador p d (v-1) l c : js
                                                      else Jogador p d v l c : tiraVidaAposLaseraux (i-1) js

{- | Elimina jogadores que foram mortos. -}
listaFinalJog :: [Jogador] -> [Jogador]
listaFinalJog [] = []
listaFinalJog (Jogador p d v l c:js) = if v < 1 then Jogador p d 0 l c : listaFinalJog js else Jogador p d v l c : listaFinalJog js

{- | Dado um Estado, retorna a lista de Posições pela qual passa um Laser, dando as posições que o laser afeta.-}
posPassaLaser :: Estado -> [Posicao]
posPassaLaser (Estado m js []) = []
posPassaLaser (Estado m js (DisparoCanhao i p d:ds)) = posPassaLaser (Estado m js ds)
posPassaLaser (Estado m js (DisparoChoque i t:ds)) = posPassaLaser (Estado m js ds)
posPassaLaser (Estado m js (DisparoLaser i p d:ds)) | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Indestrutivel = posOcupadasLaser p d ++ posPassaLaser (Estado m js ds)
                                                    | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Destrutivel = posOcupadasLaser p d ++ posPassaLaser (Estado m js ds)
                                                    | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Vazia = posOcupadasLaser p d ++ posOcupadasLaser (posSeg p d) d ++ posPassaLaser (Estado m js ds)
                                                    | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Bloco Indestrutivel = posOcupadasLaser p d ++ posPassaLaser (Estado m js ds)
                                                    | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Bloco Destrutivel =  posOcupadasLaser p d ++ posPassaLaser (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                    | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Vazia = posOcupadasLaser p d ++ posPassaLaser (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                    | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Indestrutivel = posOcupadasLaser p d ++ posPassaLaser (Estado m js ds)
                                                    | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Destrutivel = posOcupadasLaser p d ++ posPassaLaser (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                    | posicaoSeguinte == Vazia && segPosicaoSeguinte == Vazia = posOcupadasLaser p d ++ posPassaLaser (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                       where posicaoSeguinte = encontraPosicaoMatriz (posSeg p d) m
                                             segPosicaoSeguinte = encontraPosicaoMatriz (segPosSeg p d) m
                                             temJogador = posicoesNaLista [posSeg p d,segPosSeg p d] (posicoesDosJogadores (Estado m js ds))                  


{- | Dado um Estado, retorna a lista de Posições pela qual passa um Laser, dando apenas a posição principal em que o laser passa. -}
unicaPosPassaLaser :: Estado -> [Posicao]
unicaPosPassaLaser (Estado m js []) = []
unicaPosPassaLaser (Estado m js (DisparoCanhao i p d:ds)) = unicaPosPassaLaser (Estado m js ds)
unicaPosPassaLaser (Estado m js (DisparoChoque i t:ds)) = unicaPosPassaLaser (Estado m js ds)
unicaPosPassaLaser (Estado m js (DisparoLaser i p d:ds))| encontraPosicaoMatriz (posSeg p d) m == Bloco Destrutivel && encontraPosicaoMatriz (segPosSeg p d) m /= Bloco Indestrutivel = p : unicaPosPassaLaser (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                        | encontraPosicaoMatriz (posSeg p d) m == Vazia && encontraPosicaoMatriz (segPosSeg p d) m /= Bloco Indestrutivel = p : unicaPosPassaLaser (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                        | otherwise = unicaPosPassaLaser (Estado m js ds) 

{- | Dando uma Posição e uma Direção dá duas Posições, as que o laser afeta. -}
posOcupadasLaser :: Posicao -> Direcao -> [Posicao]
posOcupadasLaser (x,y) d | d == D = [(x,y),(x+1,y)]
                         | d == E = [(x,y),(x+1,y)]
                         | d == B = [(x,y),(x,y+1)]
                         | d == C = [(x,y),(x,y+1)]
                                      
{- | Dada uma lista de Posições pela qual os Lasers passam, e um disparo vê se esse Disparo é atingido, isto é, se for um Disparo de Canhão a bala resultante disso é eliminada. -}
eliminaBalasAposUmLaser :: [Posicao] -> Disparo -> [Disparo]
eliminaBalasAposUmLaser [] d = [d]
eliminaBalasAposUmLaser ((x,y):xs) (DisparoCanhao i (a,b) d) = if x == a && y == b then [] else eliminaBalasAposUmLaser xs (DisparoCanhao i (a,b) d)
eliminaBalasAposUmLaser ((x,y):xs) (DisparoLaser i p d) = [DisparoLaser i p d]
eliminaBalasAposUmLaser ((x,y):xs) (DisparoChoque i t) = [DisparoChoque i t]

{- | Dada uma lista de Posições pela qual os Lasers passam, e uma lista de Disparos, vê quais Disparos são atingidos e se forem Disparos de Canhões elimina as balas desses. -}
eliminaBalasAposLasers :: [Posicao] -> [Disparo] -> [Disparo]
eliminaBalasAposLasers [] d = d
eliminaBalasAposLasers x [] = []
eliminaBalasAposLasers (x:xs) (d:ds) = eliminaBalasAposUmLaser (x:xs) d ++ eliminaBalasAposLasers (x:xs) ds


{- | Dado o Estado de jogo, retorna uma lista de indíces dos Jogadores que foram atingidos por um Laser.  -}
jogAtingidosLasers :: Estado -> [Int]
jogAtingidosLasers (Estado m js []) = []
jogAtingidosLasers (Estado m js (DisparoCanhao i p d:ds)) = jogAtingidosLasers (Estado m js ds)
jogAtingidosLasers (Estado m js (DisparoChoque i t:ds)) = jogAtingidosLasers (Estado m js ds)
jogAtingidosLasers (Estado m js (DisparoLaser i p d:ds)) | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Indestrutivel = jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Destrutivel = jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Vazia && not temJogador = jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Vazia && temJogador = nrJogadoresAtingidosLaser 0 js (posPassaLaser (Estado m js [DisparoLaser i p d])) ++ jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Bloco Indestrutivel = jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Bloco Destrutivel = jogAtingidosLasers (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                         | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Vazia && not temJogador = jogAtingidosLasers (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                         | posicaoSeguinte == Bloco Destrutivel && segPosicaoSeguinte == Vazia && temJogador = nrJogadoresAtingidosLaser 0 js (posPassaLaser (Estado m js [DisparoLaser i p d])) ++ jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Indestrutivel = jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Destrutivel && not temJogador = jogAtingidosLasers (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                         | posicaoSeguinte == Vazia && segPosicaoSeguinte == Bloco Destrutivel && temJogador = nrJogadoresAtingidosLaser 0 js (posPassaLaser (Estado m js [DisparoLaser i p d])) ++ jogAtingidosLasers (Estado m js ds)
                                                         | posicaoSeguinte == Vazia && segPosicaoSeguinte == Vazia && not temJogador  = jogAtingidosLasers (Estado m js (DisparoLaser i (posSeg p d) d:ds))
                                                         | posicaoSeguinte == Vazia && segPosicaoSeguinte == Vazia && temJogador = nrJogadoresAtingidosLaser 0 js (posPassaLaser (Estado m js [DisparoLaser i p d])) ++ jogAtingidosLasers (Estado m js ds)
                                        where posicaoSeguinte = encontraPosicaoMatriz (posSeg p d) m
                                              segPosicaoSeguinte = encontraPosicaoMatriz (segPosSeg p d) m
                                              temJogador = posicoesNaLista [posSeg p d,segPosSeg p d] (posicoesDosJogadores (Estado m js ds))                  


{- | Dando um Jogador e uma lista de Poções verifica se esse Jogador será atingido por um Laser. -}                                                                                                                             
foiAtingidoLaser :: Jogador -> [Posicao] -> Bool
foiAtingidoLaser (Jogador p d v l c) [] = False
foiAtingidoLaser (Jogador p d v l c) ps = posicoesNaLista (quatroPosJog (Jogador p d v l c)) ps

{- | Recebendo um Inteiro, uma lista de Jogadores e uma lista de Posições devolve uma lista de inteiros que corresponde  -}
nrJogadoresAtingidosLaser :: Int -> [Jogador] -> [Posicao] -> [Int]
nrJogadoresAtingidosLaser n [] ps = []
nrJogadoresAtingidosLaser n js [] = []
nrJogadoresAtingidosLaser n (j:js) xs = if foiAtingidoLaser j xs then n : nrJogadoresAtingidosLaser (n+1) js xs else nrJogadoresAtingidosLaser (n+1) js xs

{- | Avança o 'Estado' do jogo um 'Tick' de tempo, considerando apenas os efeitos das balas de 'Canhao' disparadas.-} 
tickCanhoes :: Estado -> Estado
tickCanhoes (Estado m js ds) = Estado (aplicaEstragos (Estado m js (soCanhoes ds))) (jogadoresAposDisparos (Estado m js ds)) (passaUmTick (semRepetidas(Estado m js ds)))

{- | Dado um estado dá o mesmo estado mas sem as balas que se vão cruzar. -}
semRepetidas :: Estado -> Estado
semRepetidas (Estado m js ds) = Estado m js (eliminaBalasRepetidas ds)  

{- | Dado um estado, aplica um Tick a uma lista de disparos e dá como resultado a lista de Disparos após o Tick. -}
passaUmTick :: Estado -> [Disparo]
passaUmTick (Estado m js []) = []
passaUmTick (Estado m js (DisparoCanhao i (x,y) d:ds)) | posicoesNaLista [(x,y),posSeg (x,y) d] (unicaPosJogadores (Estado m js ds)) = passaUmTick (Estado m js ds)
                                                       | posicoesNaLista [posSeg (x,y) d,segPosSeg (x,y) d,terPosSeg (x,y) d] (unicaPosJogadores (Estado m js (DisparoCanhao i (x,y) d:ds))) = passaUmTick (Estado m js ds)
                                                       | posNaLista (x,y) (posicaoBalasMapa (Estado m js ds)) = passaUmTick (Estado m js ds)
                                                       | esqOuCima && elemPosAnt /= Vazia && elem2PosAnt /= Vazia = passaUmTick (Estado m js ds)
                                                       | esqOuCima && elemPosAnt == Vazia && elem2PosAnt == Vazia && elemPosAtual /= Vazia || elem2PosAtual /= Vazia = passaUmTick (Estado m js ds)
                                                       | esqOuCima && elemPosAnt == Vazia && elem2PosAnt == Vazia && elemPosAtual == Vazia && elem2PosAtual == Vazia = DisparoCanhao i (posSeg(x,y) d) d : passaUmTick (Estado m js ds)
                                                       | (encontraPosicaoMatriz (posSeg (x,y) d) m /= Vazia) || (encontraPosicaoMatriz (segPosSeg (x,y) d) m /= Vazia ) = passaUmTick (Estado m js ds)
                                                       | posicaoVazia2 (posSeg (x,y) d) (Estado m js disparos) && posicaoVazia2 (segPosSeg (x,y) d) (Estado m js disparos) && posicaoLivre2 (terPosSeg (x,y) d) (unicaPosJogadores (Estado m js disparos)) = DisparoCanhao i (posSeg (x,y) d) d : passaUmTick (Estado m js ds)
                                                       | not (posicaoVazia2 (posSeg (x,y) d) (Estado m js disparos)) || not (posicaoVazia2 (segPosSeg (x,y) d) (Estado m js disparos)) = passaUmTick (Estado m js ds) 
                                               where esqOuCima = d == E || d == C  
                                                     elemPosAnt = encontraPosicaoMatriz (posAnt (x,y) d) m 
                                                     elem2PosAnt = encontraPosicaoMatriz (segPosAnt (x,y) d) m 
                                                     elemPosAtual = encontraPosicaoMatriz (x,y) m 
                                                     elem2PosAtual = encontraPosicaoMatriz (segPosBala (x,y) d) m 
                                                     disparos = DisparoCanhao i (x,y) d : ds
passaUmTick (Estado m js (DisparoChoque i t:ds)) = DisparoChoque i t : passaUmTick (Estado m js ds)
passaUmTick (Estado m js (DisparoLaser i p d:ds)) = DisparoLaser i p d : passaUmTick (Estado m js ds)

-- posNaLista (posSeg (x,y) d) (posicaoBalasMapa (Estado m js (DisparoCanhao i (x,y) d:ds))) ||
-- (DisparoCanhao i ((posSeg(x,y) d)) d) : passaUmTick (Estado m js ds)

posAnt :: Posicao -> Direcao -> Posicao
posAnt (x,y) E = (x,y+1)
posAnt (x,y) C = (x+1,y)
posAnt (x,y) D = (x,y)
posAnt (x,y) B = (x,y)


segPosAnt :: Posicao -> Direcao -> Posicao
segPosAnt (x,y) E = (x+1,y+1)
segPosAnt (x,y) C = (x+1,y+1)
segPosAnt (x,y) D = (x,y)
segPosAnt (x,y) B = (x,y)

{- | Recebendo uma posição e uma Direção devolve a segunda posição que uma bala ocupa na sua posição inicial. -}
segPosBala :: Posicao -> Direcao -> Posicao
segPosBala (x,y) C = (x,y+1)
segPosBala (x,y) D = (x+1,y)
segPosBala (x,y) B = (x,y+1)
segPosBala (x,y) E = (x+1,y)


{- | Recebendo um Jogador dá as 4 Posições que este assume no mapa. -}
quatroPosJog :: Jogador -> [(Int,Int)]
quatroPosJog (Jogador (x,y) d v l c) = [(x,y),(x+1,y),(x,y+1),(x+1,y+1)] 


{- | Função que dada uma 'Posicao' e uma lista com as posições dos outros tanques (neste caso só consideramos a posição principal do tanque): Vê se a posição esta livre -}
posicaoLivre2 :: Posicao -> [Posicao] -> Bool
posicaoLivre2 (x,y) [] = True
posicaoLivre2 (x,y) ps = (x, y) `notElem` ps

{- | Função que dada uma 'Posicao' e um Estado: Vê se a posição está livre de tanques e de blocos -}
posicaoVazia2 :: Posicao -> Estado -> Bool
posicaoVazia2 (x,y) (Estado m [] d) = encontraPosicaoMatriz (x,y) m == Vazia  
posicaoVazia2 (x,y) (Estado m (j:js) d) = posicaoLivre2 (x,y) (unicaPosJogadores (Estado m (j:js) d)) && encontraPosicaoMatriz (x,y) m == Vazia 

{- | Função que dado um 'Estado' dá uma lista que representa as posições dos jogadores, dando apenas a posição principal de cada um e não as 4 que ele ocupa. -}
unicaPosJogadores :: Estado -> [Posicao]
unicaPosJogadores (Estado m [] ds) = []
unicaPosJogadores (Estado m (Jogador (x,y) d v l c:js) ds) = if v > 0 
                                                             then (x,y) : unicaPosJogadores (Estado m js ds)
                                                             else unicaPosJogadores (Estado m js ds)

{- | Função que dada uma Posição e um Direção calcula a segunda posição que a bala irá ocupar, a primeira posição é calculada por posSeg. -}
--dado uma posicao e uma direção, dá a segunda posição em que é necessario ver se esta ocupada ou não...(a primeira posição é dada por posSeg)
segPosSeg :: Posicao -> Direcao -> Posicao
segPosSeg (x,y) C = (x-1,y+1) 
segPosSeg (x,y) B = (x+1,y+1)
segPosSeg (x,y) D = (x+1,y+1)
segPosSeg (x,y) E = (x+1,y-1)

{- | Dadas duas listas de Posições verifica se as Posições da primeira lista estão presentes na segunda dando um Bool como resposta. -}
posicoesNaLista :: [Posicao] -> [Posicao] -> Bool
posicoesNaLista [] m = False
posicoesNaLista (x:xs) y = posNaLista x y || posicoesNaLista xs y
 
{- | Função que recebe um Estado e calcula a lista de Posições que os jogadores ocupam, sendo que cada jogador ocupa quatro Posições. -}
posicoesDosJogadores :: Estado -> [Posicao]
posicoesDosJogadores (Estado m [] ds) = []
posicoesDosJogadores (Estado m (Jogador (x,y) d v l c:js) ds) = (x,y):(x+1,y):(x+1,y+1):(x,y+1): posicoesDosJogadores (Estado m js ds)

{- | Função que dado um Estado dá o mapa resultante após um Tick. -}
aplicaEstragos :: Estado -> Mapa
aplicaEstragos (Estado m js []) = m
aplicaEstragos (Estado m js (DisparoCanhao i p d:ds)) | posNaLista (posSeg p d) (posicaoBalasMapa (Estado m js (DisparoCanhao i p d:ds))) && posicaoVazia (posSeg p d) (Estado m js (DisparoCanhao i p d:ds)) && posicaoVazia (segPosSeg p d) (Estado m js (DisparoCanhao i p d:ds)) = aplicaEstragos (Estado m js ds) 
                                                      | esqOuCima && elemPosAnt /= Bloco Indestrutivel && elem2PosAnt /= Bloco Indestrutivel && elemPosAtual /= Bloco Indestrutivel && elem2PosAtual /= Bloco Indestrutivel = aplicaEstragos (Estado (atualizaPosicaoMatriz p Vazia (atualizaPosicaoMatriz (segPosBala p d) Vazia m)) js ds)
                                                      | esqOuCima && elemPosAnt /= Bloco Indestrutivel && elem2PosAnt /= Bloco Indestrutivel && elemPosAtual == Bloco Indestrutivel && elem2PosAtual /= Bloco Indestrutivel = aplicaEstragos (Estado (atualizaPosicaoMatriz (segPosBala p d) Vazia m) js ds)
                                                      | esqOuCima && elemPosAnt /= Bloco Indestrutivel && elem2PosAnt /= Bloco Indestrutivel && elemPosAtual /= Bloco Indestrutivel && elem2PosAtual == Bloco Indestrutivel = aplicaEstragos (Estado (atualizaPosicaoMatriz p Vazia m) js ds)
                                                      | esqOuCima && elemPosAnt /= Bloco Indestrutivel && elem2PosAnt /= Bloco Indestrutivel && elemPosAtual == Bloco Indestrutivel && elem2PosAtual == Bloco Indestrutivel = aplicaEstragos (Estado m js ds)
                                                      | esqOuCima && elemPosAnt == Bloco Indestrutivel && elem2PosAnt == Bloco Indestrutivel = aplicaEstragos (Estado m js ds)
                                                      | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte == Bloco Indestrutivel = aplicaEstragos (Estado m js ds) 
                                                      | posicaoSeguinte /= Bloco Indestrutivel && segPosicaoSeguinte /= Bloco Indestrutivel = aplicaEstragos (Estado (atualizaPosicaoMatriz (posSeg p d) Vazia (atualizaPosicaoMatriz (segPosSeg p d) Vazia m)) js ds) 
                                                      | posicaoSeguinte == Bloco Indestrutivel && segPosicaoSeguinte /= Bloco Indestrutivel = aplicaEstragos (Estado (atualizaPosicaoMatriz (segPosSeg p d) Vazia m) js ds) 
                                                      | posicaoSeguinte /= Bloco Indestrutivel && segPosicaoSeguinte == Bloco Indestrutivel = aplicaEstragos (Estado (atualizaPosicaoMatriz (posSeg p d) Vazia m) js ds) 
                                        where posicaoSeguinte = encontraPosicaoMatriz (posSeg p d) m
                                              segPosicaoSeguinte = encontraPosicaoMatriz (segPosSeg p d) m
                                              elemPosAnt = encontraPosicaoMatriz (posAnt p d) m
                                              elem2PosAnt = encontraPosicaoMatriz (segPosAnt p d) m 
                                              elemPosAtual = encontraPosicaoMatriz p m
                                              elem2PosAtual = encontraPosicaoMatriz (segPosBala p d) m 
                                              esqOuCima = d == E || d == C 

{- | Dada um lista de Disparos dá um lista com as Posições das balas, neste caso considerando apenas a posição principal. -}
posBalas :: [Disparo] -> [Posicao]
posBalas [] = []
posBalas (DisparoCanhao i (x,y) d:ds) = (x,y) : posBalas ds 
posBalas (DisparoLaser i (x,y) d:ds) = (x,y) : posBalas ds 
posBalas (DisparoChoque i t:ds) = posBalas ds

{- | Dada um lista de Disparos dá um lista com as Posições das balas, neste caso considerando as duas posições que cada bala ocupa. Assumimos que uma bala afeta 3 pontos, o ponto central e os dois laterais de modo a ser mais fácil verificar se atingue um Jogador quando passa por cima/baixo ou lados e não vai diretamente ao centro do Jogador. -}
posicoesBalas :: [Disparo] -> [Posicao]
posicoesBalas [] = []
posicoesBalas (DisparoCanhao i (x,y) d:ds) = [posSeg (x,y) d,segPosSeg(x,y) d] ++ posicoesBalas ds 
posicoesBalas (DisparoLaser i (x,y) d:ds) = posicoesBalas ds 
posicoesBalas (DisparoChoque i y:ds) = posicoesBalas ds 

{- | Dado um lista de Disparos dá a lista de Posições que as balas ocupam.  -}
posicoesAtuaisBalas :: [Disparo] -> [Posicao]
posicoesAtuaisBalas [] = []
posicoesAtuaisBalas (DisparoCanhao i p d:ds) = [posSeg p d,segPosSeg p d,terPosSeg p d] ++ posicoesAtuaisBalas ds
posicoesAtuaisBalas (DisparoLaser i p d:ds) = posicoesAtuaisBalas ds 
posicoesAtuaisBalas (DisparoChoque i y:ds) = posicoesAtuaisBalas ds 

{- | Recebendo uma posição e uma Direção devolve a terceira posição que uma bala ocupa. -}
terPosSeg :: Posicao -> Direcao -> Posicao
terPosSeg (x,y) E = (x-1,y-1) 
terPosSeg (x,y) D = (x-1,y+1)
terPosSeg (x,y) B = (x+1,y-1)
terPosSeg (x,y) C = (x-1,y-1)

{- | Função que recebe um Estado e dá a lista de Posições ocupadas pelas balas, considerando apenas a posição principal das balas. -}
posicaoBalasMapa :: Estado -> [Posicao]
posicaoBalasMapa (Estado m js []) = []
posicaoBalasMapa (Estado m js (d:ds)) = posBalas (d:ds)

{- | Função que dada uma lista de Disparos retorna uma lista de Disparos sem as balas repetidas. -}
eliminaBalasRepetidas :: [Disparo] -> [Disparo]
eliminaBalasRepetidas [] = []
eliminaBalasRepetidas (DisparoLaser i p d:xs) = DisparoLaser i p d : eliminaBalasRepetidas xs
eliminaBalasRepetidas (DisparoChoque i t:xs) = DisparoChoque i t : eliminaBalasRepetidas xs
eliminaBalasRepetidas (DisparoCanhao i p d : xs) | disparoContrarioNaLista (DisparoCanhao i p d) xs = eliminaBalaLista p (direcaoOposta d) xs
                                                 | temBalasCruzantes (DisparoCanhao i p d) xs = eliminaBalaLista (posSeg p d) (direcaoOposta d) xs
                                                 | otherwise = DisparoCanhao i p d : eliminaBalasRepetidas xs

{- | Recebendo um Disparo e uma lista de Disparos vê se há alguma bala na lista de Disparos que irá chocar com a primeira no próximo Tick.  -}
temBalasCruzantes :: Disparo -> [Disparo] -> Bool
temBalasCruzantes (DisparoCanhao i (x,y) d) [] = False
temBalasCruzantes (DisparoCanhao i (x,y) d) (DisparoCanhao a (b,c) dir :xs) | d == C && x == (b-1) && y == c && dir == B = True
                                                                            | d == B && x == (b+1) && y == c && dir == C = True
                                                                            | d == E && x == b && y == (c+1) && dir == D = True
                                                                            | d == D && x == b && y == (c-1) && dir == E = True
                                                                            | otherwise = temBalasCruzantes (DisparoCanhao i (x,y) d) xs
temBalasCruzantes (DisparoCanhao i (x,y) dir) (DisparoChoque i2 t:xs) = temBalasCruzantes (DisparoCanhao i (x,y) dir) xs
temBalasCruzantes (DisparoCanhao i (x,y) dir) (DisparoLaser i2 (x2,y2) d:xs) = temBalasCruzantes (DisparoCanhao i (x,y) dir) xs


{- | Recebendo um Disparo e uma lista de Disparos vê se há alguma bala na lista de Disparos que irá chocar com a primeira no próximo Tick. -}
disparoContrarioNaLista :: Disparo -> [Disparo] -> Bool
disparoContrarioNaLista (DisparoCanhao i (x,y) d) [] = False
disparoContrarioNaLista (DisparoCanhao a (b,c) d) (DisparoCanhao e (f,g) h:xs) = (b == f && c == g && d /= h) || disparoContrarioNaLista (DisparoCanhao a (b, c) d) xs
disparoContrarioNaLista (DisparoCanhao i (x,y) dir) (DisparoChoque i2 t:xs) = disparoContrarioNaLista (DisparoCanhao i (x,y) dir) xs
disparoContrarioNaLista (DisparoCanhao i (x,y) dir) (DisparoLaser i2 (x2,y2) d:xs) = disparoContrarioNaLista (DisparoCanhao i (x,y) dir) xs


{- | Dada uma direção esta função calcula a direção oposta. -}
direcaoOposta :: Direcao -> Direcao
direcaoOposta x | x == D = E
                | x == E = D 
                | x == B = C 
                | x == C = B 

{- | Função que dada uma Posição de uma Bala e uma lista de Disparos, retorna uma lista de Disparos sem a Bala apresentada. -}
eliminaBalaLista :: Posicao -> Direcao -> [Disparo] -> [Disparo]
eliminaBalaLista (x,y) dir [] = []
eliminaBalaLista (x,y) dir (DisparoLaser i (a,b) d:ds) = DisparoLaser i (a,b) d : eliminaBalaLista (x,y) dir ds
eliminaBalaLista (x,y) dir (DisparoChoque i t:ds) = DisparoChoque i t : eliminaBalaLista (x,y) dir ds                                                  
eliminaBalaLista (x,y) dir (DisparoCanhao i (a,b) d:ds) = if (x == a) && (y == b)  
                                                          then eliminaBalaLista (x,y) dir ds 
                                                          else DisparoCanhao i (a,b) d : eliminaBalaLista (x,y) dir ds   

{- |Função que dado um Jogador e uma lista de Disparos dá um bool sobre se foi atingido por uma Bala de Canhão. -}
foiAtingidoBala :: Jogador -> [Disparo] -> Bool
foiAtingidoBala (Jogador (x,y) d v l c) [] = False
foiAtingidoBala (Jogador (x,y) d v l c) (DisparoCanhao i (a,b) dir:ds) | posicoesNaLista [(a,b),posSeg (a,b) dir] [(x,y)] = True
                                                                       | posNaLista (x,y) (posicoesAtuaisBalas (DisparoCanhao i (a,b) dir:ds)) = True
                                                                       | otherwise = foiAtingidoBala (Jogador (x,y) d v l c) ds

foiAtingidoBala (Jogador (x,y) d v l c) (DisparoLaser i (a,b) dir:ds) = foiAtingidoBala (Jogador (x,y) d v l c) ds
foiAtingidoBala (Jogador (x,y) d v l c) (DisparoChoque i t:ds) = foiAtingidoBala (Jogador (x,y) d v l c) ds


{- | Função que dado um Estado, aplica um Tick e dá como resultado a lista de Jogadores atualizada após o Tick. -}
jogadoresAposDisparos :: Estado -> [Jogador]
jogadoresAposDisparos (Estado m [] ds) = []
jogadoresAposDisparos (Estado m (Jogador p d v l c:js) ds) | v > 0 && foiAtingidoBala (Jogador p d v l c) ds = Jogador p d (v-1) l c : jogadoresAposDisparos (Estado m js ds)
                                                           | otherwise = Jogador p d v l c : jogadoresAposDisparos (Estado m js ds)
                                           
{- | Avança o 'Estado' do jogo um 'Tick' de tempo, considerando apenas os efeitos dos campos de 'Choque' disparados. -}
tickChoques :: Estado -> Estado
tickChoques (Estado m js ds) = Estado m js (passaUmTickChoque (Estado m js ds))

{- | Dado um Estado de jogo, atualiza a lista de Disparos após um Tick de tempo. -}
passaUmTickChoque :: Estado -> [Disparo]
passaUmTickChoque (Estado m js []) = []
passaUmTickChoque (Estado m js (DisparoLaser i p d :ds)) = DisparoLaser i p d : passaUmTickChoque (Estado m js ds)
passaUmTickChoque (Estado m js (DisparoCanhao i p d :ds)) = DisparoCanhao i p d : passaUmTickChoque (Estado m js ds)
passaUmTickChoque (Estado m js (DisparoChoque i t :ds)) = if t > 1
                                                           then DisparoChoque i (t-1) : passaUmTickChoque (Estado m js ds)
                                                           else passaUmTickChoque (Estado m js ds)
