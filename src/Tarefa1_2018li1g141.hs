{-|
Module      : Tarefa1_2018li1g141
Description : Modulo que constroi mapas 
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;
Este módulo serve para criar mapas, isto é, a funçao constroi irá receber uma lista de instruções e por sua vez irá criar uma mapa resultante destas.
-}

module Tarefa1_2018li1g141 where

import LI11819
import Tarefa0_2018li1g141
import Data.List


{- | Testes para testar exatidão do módulo. 
Cada teste é uma sequência de 'Instrucoes'.
-}

testesT1 :: [Instrucoes]
testesT1 = [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19]

-- | Teste 1
t1 :: [Instrucao]
t1 = [Move C,Move D,Move E,Move B,Desenha,MudaTetromino,MudaTetromino,Roda,Roda,Move C,Move C,Move C,Move D,Desenha]

-- | Teste 2
t2 :: [Instrucao]
t2 = [MudaTetromino,MudaTetromino,Roda,Desenha,MudaParede,Desenha,Move D,Desenha]

-- | Teste 3
t3 :: [Instrucao]
t3 = [Desenha,Roda,Desenha,Roda,Desenha]

-- | Teste 4
t4 :: [Instrucao]
t4 = [Move B,Move D,Desenha,Move B,Move B,Move B,Roda,Desenha]

-- | Teste 5 
t5 :: [Instrucao]
t5 = [MudaTetromino,MudaTetromino,MudaTetromino,Roda,Desenha]

-- | Teste 6
t6 :: [Instrucao]
t6 = [MudaParede,MudaTetromino,Roda,Desenha]

-- | Teste 7
t7 :: [Instrucao]
t7 = [Move D,Desenha,Move B,Move B,Move B,Roda,MudaParede,Move D,Move D,Move D,Desenha,Move B]

-- | Teste 8 
t8 :: [Instrucao]
t8 = [Desenha,MudaTetromino,Desenha]

-- | Teste 9
t9 :: [Instrucao]
t9 = [Move D,Desenha,Roda,MudaParede,Move B,Move B,Move D,Move D,Move B,MudaTetromino,MudaTetromino,MudaTetromino,Roda,Roda,Desenha]

-- | Teste 10
t10 :: [Instrucao]
t10 = [Move C,Desenha,Roda,Move C,Move C,MudaParede,MudaTetromino,Desenha]

-- | Teste 11
t11 :: [Instrucao]
t11 = [MudaTetromino,MudaParede,Desenha]

-- | Teste 12
t12 :: [Instrucao]
t12 = [MudaParede,Desenha,Move D,MudaParede,Desenha]

-- | Teste 13
t13 :: [Instrucao]
t13 = [Move E,Move E,Move C]

-- | Teste 14
t14 :: [Instrucao]
t14 = [Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha,MudaTetromino,Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha,MudaTetromino,Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha,MudaTetromino,Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha,MudaTetromino,Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha,MudaTetromino,Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha,MudaTetromino,Roda,Desenha,Roda,Desenha,Roda,Desenha,Roda,Desenha]

-- | Teste 15
t15 :: [Instrucao]
t15 = [Roda,Roda,MudaParede,Desenha]

-- | Teste 16
t16 :: [Instrucao]
t16 = [MudaTetromino,MudaTetromino,Roda,Roda,Roda,Desenha]

-- | Teste 17
t17 :: [Instrucao]
t17 = [Roda,Desenha,MudaParede,Desenha]

-- | Teste 18
t18 :: [Instrucao]
t18 = [Move C,Move C,Move C,Move B,Move B,Move E,Move E,Move D,Roda,MudaParede,MudaTetromino,Desenha]

-- | Teste 19
t19 :: [Instrucao]
t19 = [Roda,Roda,Roda,Roda,Roda,MudaTetromino,MudaTetromino,MudaTetromino,MudaTetromino,MudaTetromino,MudaTetromino,MudaTetromino,MudaTetromino,MudaParede,Roda,Desenha]


-- função que recebe um mapa e dá a sua lista de peças... 
-- mapaParaLista [[Bloco Indestrutivel,Bloco Indestrutivel],[Bloco Indestrutivel,Bloco Indestrutivel]] 
-- = [Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel,Bloco Indestrutivel]


{- | Função que dada uma lista de listas de 'a', dá uma lista de 'a'. Transforma um mapa numa listas de Peças. -}
mapaParaLista :: [[a]] -> [a]
mapaParaLista = concat

{- | Função que dado uma posição inicial (0,0) e uma lista de Peças '[Peca]' dá uma lista de tuplos, '[(Posicao,Peca)]'. -}
linhaParaTuplos :: Posicao -> [Peca] -> [(Posicao,Peca)]
linhaParaTuplos (l,c) [] = []
linhaParaTuplos (l,c) (x:xs) = ((l,c),x):linhaParaTuplos(l,c+1) xs


{- | Função que recebe uma posição inicial (0,0) e uma Mapa, transformando o mapa numa lista de linhas(listas) de tuplos com (Posição,Peca). -}
mapaParaTuplos :: Posicao -> Mapa -> [[(Posicao, Peca)]]
mapaParaTuplos (l,c) [] = []
mapaParaTuplos (l,c) (x:xs) = linhaParaTuplos (l,c) x : mapaParaTuplos (l+1,c) xs

{- | Função que recebe um Mapa e dá uma lista de (Posições,Peças) equivalentes ao mapa. -}
mapaEmLista :: Mapa -> [(Posicao,Peca)]
mapaEmLista m = mapaParaLista(mapaParaTuplos (0,0) m)

{- | Função que recebe um Tetromino como uma lista de tuplos e um Mapa, também como lista de tuplos e dá como resultado dá uma lista [(Posição,Peça)] que equivale ao mapa com o Tetromino. -}
desenhaMapa :: [(Posicao, Peca)] -> [(Posicao, Peca)] -> [(Posicao, Peca)]
desenhaMapa [] m = m
--desenhaMapa t [] = []
desenhaMapa (((x1,y1),p1):xs) (((x2,y2),p2):ys) | x1==x2 && y1==y2 && p1 == Vazia = ((x2,y2),p2) : desenhaMapa xs ys
                                                | x1==x2 && y1==y2 && p1 /= Vazia = ((x2,y2),p1) : desenhaMapa xs ys
                                                | otherwise = ((x2,y2),p2) : desenhaMapa (((x1,y1),p1):xs) ys
 

{- | Função que dada uma lista de (Posicao,Peca), devolve uma lista de peças sem as devidas coordenadas. -} 
mapaSemCoordenadas :: [(Posicao,Peca)] -> [Peca]
mapaSemCoordenadas = map snd 

{- | Função que dada uma 'Posicao' e uma lista de Peças, devolve uma lista de listas de Peças, que corresponde ao mapa final. -}
mapaFinal :: Posicao -> [Peca] -> [[Peca]]
mapaFinal x [] = []
mapaFinal (x,y) l | y >=1 = mapaFinalAux (x,y) l : mapaFinal (x,y-1) ((\\) l (mapaFinalAux (x,y) l))
                  | otherwise = [] 
        where mapaFinalAux w [] = []
              mapaFinalAux (y,z) (x:xs) | y >= 1 = x : mapaFinalAux (y-1,z) xs
                                        | otherwise = []


{- |Função que dada uma Posição, um Tetromino e uma Direção dá uma lista de (Posição,Peça). -}
tetrominoComDirecao :: Posicao -> Tetromino -> Direcao -> Parede -> [(Posicao,Peca)]

tetrominoComDirecao (l,c) I C tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia,Vazia],[Vazia,Bloco tipoParede,Vazia,Vazia],[Vazia,Bloco tipoParede,Vazia,Vazia],[Vazia,Bloco tipoParede,Vazia,Vazia]])
tetrominoComDirecao (l,c) I D tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Vazia,Vazia],[Vazia,Vazia,Vazia,Vazia]])
tetrominoComDirecao (l,c) I B tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Bloco tipoParede,Vazia],[Vazia,Vazia,Bloco tipoParede,Vazia],[Vazia,Vazia,Bloco tipoParede,Vazia],[Vazia,Vazia,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) I E tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia,Vazia],[Vazia,Vazia,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Vazia,Vazia]])

tetrominoComDirecao (l,c) J C tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia],[Bloco tipoParede,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) J D tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Bloco tipoParede,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Vazia]])
tetrominoComDirecao (l,c) J B tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Bloco tipoParede],[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) J E tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Bloco tipoParede]])

tetrominoComDirecao (l,c) L C tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Bloco tipoParede]])
tetrominoComDirecao (l,c) L D tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Bloco tipoParede,Vazia,Vazia]])
tetrominoComDirecao (l,c) L B tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Bloco tipoParede,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) L E tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Bloco tipoParede],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Vazia]])

tetrominoComDirecao (l,c) O _ tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Bloco tipoParede,Bloco tipoParede],[Bloco tipoParede,Bloco tipoParede]])

tetrominoComDirecao (l,c) S C tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Bloco tipoParede],[Bloco tipoParede,Bloco tipoParede,Vazia],[Vazia,Vazia,Vazia]])
tetrominoComDirecao (l,c) S D tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Bloco tipoParede]])
tetrominoComDirecao (l,c) S B tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia],[Vazia,Bloco tipoParede,Bloco tipoParede],[Bloco tipoParede,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) S E tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Bloco tipoParede,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia]])

tetrominoComDirecao (l,c) T C tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) T D tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Bloco tipoParede,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) T B tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Bloco tipoParede,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Vazia]])
tetrominoComDirecao (l,c) T E tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Bloco tipoParede],[Vazia,Bloco tipoParede,Vazia]])

tetrominoComDirecao (l,c) Z C tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Bloco tipoParede,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Bloco tipoParede],[Vazia,Vazia,Vazia]])
tetrominoComDirecao (l,c) Z D tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Bloco tipoParede],[Vazia,Bloco tipoParede,Bloco tipoParede],[Vazia,Bloco tipoParede,Vazia]])
tetrominoComDirecao (l,c) Z B tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Vazia,Vazia],[Bloco tipoParede,Bloco tipoParede,Vazia],[Vazia,Bloco tipoParede,Bloco tipoParede]])
tetrominoComDirecao (l,c) Z E tipoParede = mapaParaLista (mapaParaTuplos (l,c) [[Vazia,Bloco tipoParede,Vazia],[Bloco tipoParede,Bloco tipoParede,Vazia],[Bloco tipoParede,Vazia,Vazia]])


--  instrucao :: Instrucao -- ^ A 'Instrucao' a aplicar.
--          -> Editor    -- ^ O 'Editor' anterior.
--          -> Editor    -- ^ O 'Editor' resultante após aplicar a 'Instrucao'.

-- | Aplica uma 'Instrucao' num 'Editor'.
--
--    * 'Move' - move numa dada 'Direcao'.
--
--    * 'MudaTetromino' - seleciona a 'Peca' seguinte (usar a ordem léxica na estrutura de dados),
--       sem alterar os outros parâmetros.
--
--    * 'MudaParede' - muda o tipo de 'Parede'.
--
--    * 'Desenha' - altera o 'Mapa' para incluir o 'Tetromino' atual, sem alterar os outros parâmetros.

instrucao :: Instrucao -> Editor -> Editor
instrucao (Move C) (Editor (l,c) d te pe m) = Editor (l-1,c) d te pe m
instrucao (Move B) (Editor (l,c) d te pe m) = Editor (l+1,c) d te pe m 
instrucao (Move D) (Editor (l,c) d te pe m) = Editor (l,c+1) d te pe m
instrucao (Move E) (Editor (l,c) d te pe m) = Editor (l,c-1) d te pe m 
instrucao Roda (Editor p C te pe m) = Editor p D te pe m
instrucao Roda (Editor p D te pe m) = Editor p B te pe m
instrucao Roda (Editor p B te pe m) = Editor p E te pe m
instrucao Roda (Editor p E te pe m) = Editor p C te pe m
instrucao MudaTetromino (Editor p d I pe m) = Editor p d J pe m
instrucao MudaTetromino (Editor p d J pe m) = Editor p d L pe m
instrucao MudaTetromino (Editor p d L pe m) = Editor p d O pe m
instrucao MudaTetromino (Editor p d O pe m) = Editor p d S pe m
instrucao MudaTetromino (Editor p d S pe m) = Editor p d T pe m
instrucao MudaTetromino (Editor p d T pe m) = Editor p d Z pe m
instrucao MudaTetromino (Editor p d Z pe m) = Editor p d I pe m
instrucao MudaParede (Editor p d te Indestrutivel m) = Editor p d te Destrutivel m
instrucao MudaParede (Editor p d te Destrutivel m) = Editor p d te Indestrutivel m
instrucao Desenha (Editor (l,c) d te tipoParede m) = Editor (l,c) d te tipoParede (mapaFinal (dimensaoMapa m) (mapaSemCoordenadas (desenhaMapa (tetrominoComDirecao (l,c) te d tipoParede) (mapaEmLista m))))

{- | Função que dado um Mapa calcula a sua dimensão. -}
dimensaoMapa :: Mapa -> Dimensao
dimensaoMapa [] = (0,0)
dimensaoMapa [[]] = (0,0)
dimensaoMapa ([]:xs) = dimensaoMatriz xs
dimensaoMapa m = (length(head m),length m)


{- | Função que aplica uma sequência de Instruções num Editor, dando um novo Editor. -}
instrucoes :: Instrucoes -> Editor -> Editor 
instrucoes [] (Editor p d te pe me) = Editor p d te pe me 
instrucoes (x:xs) (Editor p d te pe me) = instrucoes xs (instrucao x (Editor p d te pe me))


{- | Função que dada uma Dimensão cria um Mapa inicial com Parede nas bordas e o resto vazio. -}
mapaInicial :: Dimensao -> Mapa 
mapaInicial (l,c) = criaParede (l,c) (criaMatrizVazia (l,c) Vazia)

{- | Função que dada uma Dimensão cria uma matriz dessa dimensão com a Peça Vazia. -}
criaMatrizVazia :: Dimensao -> Peca -> Mapa
criaMatrizVazia (0,c) Vazia = [] 
criaMatrizVazia (l,0) Vazia = []
criaMatrizVazia (l,c) Vazia = criaColunaVazia (l,c) Vazia : criaMatrizVazia (l-1,c) Vazia 

{- | Função que cria uma coluna com Peças Vazia para depois ser usada para criar uma Matriz com as mesmas Peças. -}
criaColunaVazia :: Dimensao -> Peca -> [Peca]
criaColunaVazia (x,0) Vazia = []
criaColunaVazia (0,y) Vazia = []
criaColunaVazia (x,y) Vazia = Vazia : criaColunaVazia (x,y-1) Vazia

{- |Função que dado um mapa com peças Vazia cria as paredes/bordas desse mapa. -}
criaParede :: Dimensao -> Mapa -> Mapa
criaParede (0,0) m = atualizaPosicaoMatriz (0,0) (Bloco Indestrutivel) m
criaParede (l, c) m | c == 0 = if eBordaMatriz (l, c) m then criaParede (l - 1, length (head m) - 1) (atualizaPosicaoMatriz (l, c) (Bloco Indestrutivel) m) else criaParede (l - 1, length (head m) - 1) m
                    | eBordaMatriz (l, c) m = criaParede (l, c - 1) (atualizaPosicaoMatriz (l, c) (Bloco Indestrutivel) m)
                    | otherwise = criaParede (l, c - 1) m

{- | Dado uma sequência de Instroções cria um Editor inicial usando o Tetromino I Indestrutivel voltado para Cima. -}
editorInicial :: Instrucoes -> Editor 
editorInicial i = editorInicialA i (Editor (posicaoInicial i) C I Indestrutivel (mapaInicial(dimensaoInicial i)))

{- | Função que recebe Instruções e um Editor e dá o Editor resultante. -}
editorInicialA :: Instrucoes -> Editor -> Editor 
editorInicialA [e] (Editor p d te pe m) = instrucao e (Editor p d te pe m)
editorInicialA (x:xs) (Editor p d te pe m) = editorInicialA xs (instrucao x (Editor p d te pe m))

{-| Função que dado um Editor vai buscar o seu Mapa. -}
escolheMapa :: Editor -> Mapa
escolheMapa (Editor (l,c) d te pe me) = me 

{- | Função que dada uma sequência de Instruções constrói um Mapa. -}
constroi :: Instrucoes -> Mapa
constroi  i  = escolheMapa (editorInicial i)