{-|
Module      : Tarefa2_2018li1g141
Description : Modulo que define funções para efetuar jogadas
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;
O objectivo desta tarefa é, dada uma descrição do estado do jogo e uma jogada de um dos jogadores, determinar o efeito dessa jogada no estado do jogo.

-}

module Tarefa2_2018li1g141 where

import LI11819
import Tarefa0_2018li1g141
import Tarefa1_2018li1g141
import Data.List


{- | Testes para testar exatidão do módulo. 
Cada teste é um triplo (/identificador do 'Jogador'/,/'Jogada' a efetuar/,/'Estado' anterior/).
-}

testesT2 :: [(Int,Jogada,Estado)]
testesT2 = [t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38,t39,t40,t41,t42,t43,t44,t45,t46,t47,t48,t49,t50,t51,t52]

-- | Teste 20
t20 :: (Int,Jogada,Estado)
t20 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [])

-- | Teste 21
t21 :: (Int,Jogada,Estado)
t21 = (1,Movimenta D,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [])

-- | Teste 22
t22 :: (Int,Jogada,Estado)
t22 = (1,Movimenta E,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 2 3,DisparoChoque 0 3])

-- | Teste 23
t23 :: (Int,Jogada,Estado)
t23 = (2,Movimenta B,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [])

-- | Teste 24
t24 :: (Int,Jogada,Estado)
t24 = (2,Movimenta E,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [])

-- | Teste 25
t25 :: (Int,Jogada,Estado)
t25 = (0,Movimenta D,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [])

-- | Teste 26
t26 :: (Int,Jogada,Estado)
t26 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (3,3) C 3 4 5,Jogador (5,5) D 3 4 5,Jogador (6,1) D 3 4 5] [])

-- | Teste 27
t27 :: (Int,Jogada,Estado)
t27 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 28
t28 :: (Int,Jogada,Estado)
t28 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (3,3) D 3 4 5,Jogador (1,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 29
t29 :: (Int,Jogada,Estado)
t29 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (1,1) C 3 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 30
t30 :: (Int,Jogada,Estado)
t30 = (0,Movimenta E,Estado (mapaInicial (10,10)) [Jogador (1,1) E 3 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 31
t31 :: (Int,Jogada,Estado)
t31 = (1,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (1,1) B 3 4 5,Jogador (3,1) C 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 32
t32 :: (Int,Jogada,Estado)
t32 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (1,1) C 3 4 5,Jogador (1,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 33
t33 :: (Int,Jogada,Estado)
t33 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 34
t34 :: (Int,Jogada,Estado)
t34 = (0,Movimenta B,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 35
t35 :: (Int,Jogada,Estado)
t35 = (1,Dispara Choque,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 36
t36 :: (Int,Jogada,Estado)
t36 = (0,Dispara Canhao,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 37
t37 :: (Int,Jogada,Estado)
t37 = (1,Dispara Laser,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 38
t38 :: (Int,Jogada,Estado)
t38 = (2,Dispara Choque,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 39
t39 :: (Int,Jogada,Estado)
t39 = (1,Dispara Choque,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 40
t40 :: (Int,Jogada,Estado)
t40 = (0,Dispara Laser,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 41
t41 :: (Int,Jogada,Estado)
t41 = (0,Dispara Canhao,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 42
t42 :: (Int,Jogada,Estado)
t42 = (1,Dispara Laser,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 43
t43 :: (Int,Jogada,Estado)
t43 = (1,Dispara Canhao,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 44
t44 :: (Int,Jogada,Estado)
t44 = (2,Dispara Laser,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 45
t45 :: (Int,Jogada,Estado)
t45 = (2,Dispara Canhao,Estado (mapaInicial (10,10)) [Jogador (1,1) C 0 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 46
t46 :: (Int,Jogada,Estado)
t46 = (0,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (6,6) C 3 4 5,Jogador (4,4) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 0 3])

-- | Teste 47
t47 :: (Int,Jogada,Estado)
t47 = (0,Movimenta D,Estado (mapaInicial (10,10)) [Jogador (1,1) D 3 4 5,Jogador (2,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3])

-- | Teste 48
t48 :: (Int,Jogada,Estado)
t48 = (2,Movimenta B,Estado (mapaInicial (10,10)) [Jogador (1,1) C 3 4 5,Jogador (4,1) D 3 4 5,Jogador (6,1) B 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 49
t49 :: (Int,Jogada,Estado)
t49 = (1,Movimenta C,Estado (mapaInicial (10,10)) [Jogador (1,1) D 3 4 5,Jogador (2,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoLaser 1 (6,5) C,DisparoChoque 0 3])

-- | Teste 50
t50 :: (Int,Jogada,Estado)
t50 = (2,Movimenta D,Estado (mapaInicial (10,10)) [Jogador (1,1) C 3 4 5,Jogador (4,1) D 3 4 5,Jogador (6,4) E 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])

-- | Teste 51
t51 :: (Int,Jogada,Estado)
t51 = (0,Movimenta D,Estado (mapaInicial (10,10)) [Jogador (1,1) D 3 4 5,Jogador (2,3) D 3 4 5,Jogador (6,1) D 3 4 5] [DisparoLaser 0 (6,5) D,DisparoChoque 1 3])

-- | Teste 52
t52 :: (Int,Jogada,Estado)
t52 = (2,Movimenta B,Estado (mapaInicial (10,10)) [Jogador (3,3) C 3 4 5,Jogador (4,1) D 3 4 5,Jogador (6,1) B 3 4 5] [DisparoCanhao 0 (6,5) D,DisparoChoque 1 3,DisparoChoque 0 3])


{- | Função que dado um Int, uma Jogada e um Estado: Efetua uma jogada. -}
-- (Estado m js d) onde m é o mapa do jogo; js é a Lista de 'Jogador'es, com identificador igual ao indice na lista; e ds a Lista 'Disparo's em curso. 
jogada :: Int -- ^ O identificador do 'Jogador' que efetua a jogada.
       -> Jogada -- ^ A 'Jogada' a efetuar.
       -> Estado -- ^ O 'Estado' anterior.
       -> Estado -- ^ O 'Estado' resultante após o jogador efetuar a jogada.


jogada x (Movimenta C) (Estado m js ds) = Estado m (atualizaListaJogadores x (movimentaJogador x (Estado m js ds) (encontraJogador x (Estado m js ds)) C) js) ds
jogada x (Movimenta D) (Estado m js ds) = Estado m (atualizaListaJogadores x (movimentaJogador x (Estado m js ds) (encontraJogador x (Estado m js ds)) D) js) ds
jogada x (Movimenta B) (Estado m js ds) = Estado m (atualizaListaJogadores x (movimentaJogador x (Estado m js ds) (encontraJogador x (Estado m js ds)) B) js) ds
jogada x (Movimenta E) (Estado m js ds) = Estado m (atualizaListaJogadores x (movimentaJogador x (Estado m js ds) (encontraJogador x (Estado m js ds)) E) js) ds

jogada x (Dispara Canhao) (Estado m js ds) = if estaVivo (encontraJogador x (Estado m js ds)) 
                                             then Estado m js (adicionaDisparo x Canhao (Estado m js ds))
                                             else Estado m js ds

jogada x (Dispara Laser) (Estado m js ds) = if temAmmo Laser x (Estado m js ds) && estaVivo (encontraJogador x (Estado m js ds)) 
                                            then Estado m (atualizaListaJogadores x (aplicaDisparo x Laser (Estado m js ds)) js) (adicionaDisparo x Laser (Estado m js ds))
                                            else Estado m js ds

jogada x (Dispara Choque) (Estado m js ds) = if temAmmo Choque x (Estado m js ds) && estaVivo (encontraJogador x (Estado m js ds)) 
                                             then Estado m (atualizaListaJogadores x (aplicaDisparo x Choque (Estado m js ds)) js) (adicionaDisparo x Choque (Estado m js ds))
                                             else Estado m js ds



{- | Função que dado um inteiro (identificador do 'Jogador') e um Estado: Dá o jogador correspondente  -}
-- (Estado m (j:js) d) onde m é o mapa do jogo; (j:js) é a Lista de 'Jogador'es, com identificador igual ao indice na lista; e d a Lista 'Disparo's em curso. 
encontraJogador :: Int -> Estado -> Jogador
encontraJogador x (Estado m (j:js) d) = if x == 0
                                        then j
                                        else encontraJogador (x-1) (Estado m js d)

{- | Função que dado um 'Jogador': Dá True se esse 'Jogador' estiver vivo (v>0) -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
estaVivo :: Jogador -> Bool
estaVivo (Jogador (x,y) d v l c) = v > 0

{- | Função que dado um 'Jogador': Vê se esse 'Jogador' tem choques -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
temChoque :: Jogador -> Bool
temChoque (Jogador (x,y) d v l c) = c > 0 

{- | Função que dado um 'Jogador': Vê se esse 'Jogador' tem lasers -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
temLaser :: Jogador -> Bool
temLaser (Jogador (x,y) d v l c) = l > 0

{- | Função que dado uma 'Arma', um inteiro (identificador do 'Jogador'), e um Estado: Verifica se tem munição -}
-- (Estado m js d) onde m é o mapa do jogo; js é a Lista de 'Jogador'es, com identificador igual ao indice na lista; e d a Lista 'Disparo's em curso. 
temAmmo :: Arma -> Int -> Estado -> Bool
temAmmo Canhao a (Estado m js d) = True
temAmmo Laser a (Estado m js d) = temLaser (encontraJogador a (Estado m js d))
temAmmo Choque a (Estado m js d) = temChoque (encontraJogador a (Estado m js d))

{- | Com base na Posição atual e na sua Direção esta função dá a Posição seguinte. -}
posSeg :: Posicao -> Direcao -> Posicao
posSeg (x,y) C = (x-1,y)
posSeg (x,y) B = (x+1,y)
posSeg (x,y) D = (x,y+1)
posSeg (x,y) E = (x,y-1)

{- | Função que dado um inteiro (identificador do 'Jogador'), uma 'Arma' e um Estado: Adiciona o disparo à lista de disparos. -}
-- (Estado m js d) onde m é o mapa do jogo; js é a Lista de 'Jogador'es, com identificador igual ao indice na lista; e ds a Lista 'Disparo's em curso. 
adicionaDisparo :: Int -> Arma -> Estado -> [Disparo]
adicionaDisparo x Canhao (Estado m js ds) = DisparoCanhao x (posSeg(posJogador x js) (direcaoJog x js)) (direcaoJog x js) : ds
adicionaDisparo x Laser (Estado m js ds) = DisparoLaser x (posSeg(posJogador x js) (direcaoJog x js)) (direcaoJog x js) : ds
adicionaDisparo x Choque (Estado m js ds) = DisparoChoque x 5 : ds

{- | Função que dado um inteiro (identificador do 'Jogador'), uma 'Arma' e um Estado: Dá o estado resultante de retirar a munição -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
aplicaDisparo :: Int -> Arma -> Estado -> Jogador
aplicaDisparo i Laser (Estado m (Jogador p d v l c:js) ds) = if i == 0
                                                             then Jogador p d v (l-1) c
                                                             else aplicaDisparo (i-1) Laser (Estado m js ds)
aplicaDisparo i Choque (Estado m (Jogador p d v l c:js) ds) = if i == 0
                                                              then Jogador p d v l (c-1)
                                                              else aplicaDisparo (i-1) Choque (Estado m js ds)

{- | Função que dada uma 'Posicao' e um Estado: Vê se a posição está livre de tanques e de blocos -}
posicaoVazia :: Posicao -> Estado -> Bool
posicaoVazia (x,y) (Estado m (j:js) d) = posicaoLivre (x,y) (jogadoresParaPosicoes (Estado m (j:js) d)) && encontraPosicaoMatriz (x,y) m == Vazia 


{- | Função que dada uma 'Posicao' e uma lista com as posições dos outros tanques (cada tanque ocupa 4 posições no mapa): Vê se a posição esta livre -}
posicaoLivre :: Posicao -> [(Int,Posicao,Posicao,Posicao,Posicao)] -> Bool
posicaoLivre (x,y) [] = True
posicaoLivre (x,y) ((c,(a1,b1),(a2,b2),(a3,b3),(a4,b4)):t) = not ((x == a1 && y == b1) || (x == a2 && y == b2) || (x == a3 && y == b3) || (x == a4 && y == b4)) && posicaoLivre (x, y) t

{- | Função que dado um Inteiro correspondente a primeira posição (0) e uma Lista de 'Jogador'es: Dá uma lista de tuplos que corresponde a posição dele na lista de jogador e na grelha -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
posOcupadasJogador :: Int -> [Jogador] -> [(Int,(Int,Int),(Int,Int),(Int,Int),(Int,Int))] 
posOcupadasJogador n [] = []
posOcupadasJogador n (Jogador (x,y) d v l c:xs) = if v > 0 
                                                  then (n,(x,y),(x+1,y),(x,y+1),(x+1,y+1)) : posOcupadasJogador (n+1) xs
                                                  else posOcupadasJogador (n+1) xs

{- | Função que dado um Estado: Dá a lista com um inteiro (identificador do 'Jogador') e com as 4 posições que ocupam no mapa -}
-- (Estado m (j:js) d) onde m é o mapa do jogo; (j:js) é a Lista de 'Jogador'es, com identificador igual ao indice na lista; e d a Lista 'Disparo's em curso. 
jogadoresParaPosicoes :: Estado -> [(Int,(Int,Int),(Int,Int),(Int,Int),(Int,Int))] 
jogadoresParaPosicoes (Estado m (j:js) d) = posOcupadasJogador 0 (j:js)

{- | Função que dado um inteiro (identificador do 'Jogador') e uma lista de 'Jogador'es: Dá a 'Direcao' do Jogador na posição i -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
direcaoJog :: Int -> [Jogador] -> Direcao
direcaoJog i (Jogador (x,y) d v l c:js) = if i == 0
                                            then d
                                            else direcaoJog (i-1) js

{- | Função que dado um inteiro (identificador do 'Jogador') e uma lista de 'Jogador'es: Dá a posição do jogador correspondente ao inteiro -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
posJogador :: Int -> [Jogador] -> Posicao
posJogador i (Jogador (x,y) d v l c:js) = if i == 0
                                          then (x,y)
                                          else posJogador (i-1) js

{- | Função que dado um inteiro (identificador do 'Jogador') e uma lista de 'Jogador'es: Dá uma lista com o identificar do jogador e a sua posição -} 
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
posJogadorAux :: Int -> [Jogador] -> [(Int,(Int,Int))]
posJogadorAux i [] = []
posJogadorAux i (Jogador (x,y) d v l c:js) = (i,(x,y)) : posJogadorAux (i+1) js

{- | Função que dado uma lista das posições onde os jogadores que tem choques ativos estão, e uma lista de todos os jogadores e as suas posições: Dá uma lista das posições dos jogadores que tem choques ativos. -}
posJogChoqueAux :: [Int] -> [(Int,(Int,Int))] -> [(Int,(Int,Int))]
posJogChoqueAux [] (x:xs) = []
posJogChoqueAux i [] = []
posJogChoqueAux (i:is) ((nj,(x,y)):xs) = if i == nj
                                         then (nj,(x,y)) : posJogChoqueAux is xs
                                         else posJogChoqueAux (i:is) xs

{- | Função que dador um Estado: Dá uma lista de inteiros (identificador do 'Jogador') que têm choque ativo -}
indJogChoque :: Estado -> [Int]
indJogChoque (Estado m js []) = []
indJogChoque (Estado m js (DisparoChoque nj nt:ds)) = nj : indJogChoque (Estado m js ds)
indJogChoque (Estado m js (DisparoLaser nj (a,b) d:ds)) = indJogChoque (Estado m js ds)
indJogChoque (Estado m js (DisparoCanhao nj (a,b) d:ds)) = indJogChoque (Estado m js ds)

{- | Função que ordena uma lista (usada para organizar a listas de indices resultantes da função indJogChoque) -}
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort l = minimum l : iSort (delete (minimum l) l)

{- | Função que dadas as posições dos jogadores que dispararam os choques: Calcula a matriz sobre a qual o choques tem efeito, dando uma lista com o identificador do jogador do disparo e a lista de posições com choque -}
matrizComChoqueAux :: [(Int,(Int,Int))] -> [(Int,[Posicao])]
matrizComChoqueAux [] = []
matrizComChoqueAux ((nj,(x,y)): njs) = (nj,soCoordenadas (mapaParaLista(mapaParaTuplos (x-2,y-2) (mapaInicial (6,6))))) : matrizComChoqueAux njs

{- | Função que dado o inteiro (identificador do 'Jogador') e uma Lista de 'Posicao's onde o mapa tem choques ativos: Elimina o choque dele para se poder mexer. -}
eliminaChoqueProprio :: Int -> [(Int,[Posicao])] -> [(Int,[Posicao])]
eliminaChoqueProprio i [] = []
eliminaChoqueProprio i ((nj,(x,y):xs):ys) | i == nj = ys
                                          | i > nj = (nj, (x, y) : xs) : eliminaChoqueProprio i ys
                                          | otherwise = (nj, (x, y) : xs) : ys
                                                
{- | Função que dado um Estado: Dá as posições do mapas que têm choque -}
posicoesChoquesAtivosAux :: Estado -> [(Int,[Posicao])]
posicoesChoquesAtivosAux (Estado m js ds) = if temChoquesAtivos ds 
                                            then matrizComChoqueAux (posJogChoqueAux (iSort(indJogChoque (Estado m js ds))) (posJogadorAux 0 js))
                                            else []

{- | Função que dado uma lista de (Posicao,Peca): Devolve só as posições. -}
soCoordenadas :: [(Posicao,Peca)] -> [Posicao]
soCoordenadas [] = []
soCoordenadas (((x,y),p):t) = (x,y) : soCoordenadas t

{- | Função que dado uma lista de 'Disparo's: Verifica se a lista tem pelo menos um choque ativo. --}
temChoquesAtivos :: [Disparo] -> Bool
temChoquesAtivos [] = False
temChoquesAtivos (DisparoChoque x t:ds) = True
temChoquesAtivos (DisparoCanhao x (x1,x2) d:ds) = temChoquesAtivos ds
temChoquesAtivos (DisparoLaser x (x1,x2) d:ds) = temChoquesAtivos ds

{- | Função que dada uma 'Posicao' e uma Lista de 'Posicao's : Vê se essa posição está presente numa lista de posições -}
posNaLista :: Posicao -> [Posicao] -> Bool
posNaLista (x,y) [] = False
posNaLista (x,y) ((a,b):t) = (x == a && y == b) || posNaLista (x, y) t

{- | Função que dada uma 'Posicao' e uma Lista de 'Posicao's: Verifica se essa posição está presente numa lista de posições -}
posNaListaAux :: Posicao -> [(Int,[Posicao])] -> Bool
posNaListaAux (a,y) [] = False
posNaListaAux (a,b) ((nj,(x,y):xs):ys) = posNaLista (a, b) ((x, y) : xs) || posNaListaAux (a, b) ys

{- | Função que dado um inteiro (identificador do 'Jogador'), um 'Jogador' e uma lista de 'Jogador'es: Atualiza a lista de jogadores após a jogada -}
-- '(Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
atualizaListaJogadores :: Int -> Jogador -> [Jogador] -> [Jogador]
atualizaListaJogadores i (Jogador p d v l c) [] = [Jogador p d v l c]
atualizaListaJogadores i (Jogador p d v l c) (j:js) = if i == 0
                                                      then Jogador p d v l c : js
                                                      else j : atualizaListaJogadores (i-1) (Jogador p d v l c) js


{- | Função que dado um inteiro (identificador do 'Jogador'), um Estado, um 'Jogador' e uma 'Direcao': Com a função posicaoVazia vamos ver a se posição está vazia: se estiver e se o tanque estiver virado já na direção certa modificamos a posição, doutra maneira ficamos na mesma posição com o tanque virado para a direção dada. Além disso apenas se pode movimentar quando em vidas (v>0) e quando nao ocupa uma posição com choque ativo. -}
-- (Jogador (x,y) d v l c) onde (x,y) é a posição que ocupa; d a sua direção; v o número de vidas; l o número de lasers; e c o número de choques'
-- (Estado m js d) onde m é o mapa do jogo; js é a Lista de 'Jogador'es, com identificador igual ao indice na lista; e d a Lista 'Disparo's em curso. 
movimentaJogador :: Int -> Estado -> Jogador -> Direcao -> Jogador

movimentaJogador nj (Estado m js d) (Jogador (x,y) d1 v l c) D | d1 == D && v > 0 && posicaoVazia (x,y+2) (Estado m js d) && posicaoVazia (x+1,y+2) (Estado m js d) && not (posNaListaAux (x,y) (eliminaChoqueProprio nj (posicoesChoquesAtivosAux (Estado m js d)))) = Jogador (x,y+1) D v l c 
                                                               | d1 /= D && v > 0 = Jogador (x,y) D v l c
                                                               | otherwise = Jogador (x,y) d1 v l c

movimentaJogador nj (Estado m js d) (Jogador (x,y) d1 v l c) E | d1 == E && v > 0 && posicaoVazia (x,y-1) (Estado m js d) && posicaoVazia (x+1,y-1) (Estado m js d) && not (posNaListaAux (x,y) (eliminaChoqueProprio nj (posicoesChoquesAtivosAux (Estado m js d)))) = Jogador (x,y-1) E v l c
                                                               | d1 /= E && v > 0 = Jogador (x,y) E v l c
                                                               | otherwise = Jogador (x,y) d1 v l c

movimentaJogador nj (Estado m js d) (Jogador (x,y) d1 v l c) B | d1 == B && v > 0 && posicaoVazia (x+2,y) (Estado m js d) && posicaoVazia (x+2,y+1) (Estado m js d) && not (posNaListaAux (x,y) (eliminaChoqueProprio nj (posicoesChoquesAtivosAux (Estado m js d)))) = Jogador (x+1,y) B v l c
                                                               | d1 /= B && v > 0 = Jogador (x,y) B v l c
                                                               | otherwise = Jogador (x,y) d1 v l c

movimentaJogador nj (Estado m js d) (Jogador (x,y) d1 v l c) C | d1 == C && v > 0 && posicaoVazia (x-1,y) (Estado m js d) && posicaoVazia (x-1,y+1) (Estado m js d) && not (posNaListaAux (x,y) (eliminaChoqueProprio nj (posicoesChoquesAtivosAux (Estado m js d)))) = Jogador (x-1,y) C v l c
                                                               | d1 /= C && v > 0 = Jogador (x,y) C v l c
                                                               | otherwise = Jogador (x,y) d1 v l c                                                             