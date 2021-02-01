{-|
Module      : Tarefa0_2018li1g141
Description : Modulo que define funções úteis postumamente
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;
Este módulo define funções genéricas sobre vetores e matrizes, que serão úteis na resolução do trabalho prático.
-}

module Tarefa0_2018li1g141 where

import LI11819

-- * Funções não-recursivas.

-- | Um 'Vetor' é uma 'Posicao' em relação à origem.
type Vetor = Posicao
-- ^ <<http://oi64.tinypic.com/mhvk2x.jpg vetor>>

-- ** Funções sobre vetores

-- *** Funções gerais sobre 'Vetor'es.

{- | Função que dados dois vetors calcula a sua Soma -}
somaVetores :: Vetor -> Vetor -> Vetor
somaVetores (x1,y1) (x2,y2) = (x1+x2,y1+y2)

{- | Função que dados dois vetors calcula a sua Diferença -}
subtraiVetores :: Vetor -> Vetor -> Vetor
subtraiVetores (x1,y1) (x2,y2) = (x1-x2,y1-y2)

{- | Função que dados dois vetors calcula o seu Produto -}
multiplicaVetor :: Int -> Vetor -> Vetor
multiplicaVetor a (x,y) = (a*x,a*y)

{- | Função que dado um vetor: Roda um 'Vetor' 90º no sentido dos ponteiros do relógio, alterando a sua direção sem alterar o seu comprimento (distância à origem).
-- <<http://oi65.tinypic.com/2j5o268.jpg rodaVetor>> -}
rodaVetor :: Vetor -> Vetor
rodaVetor (x,y) = (y,-x) 

{- | Função que dado um Vetor: Espelha um 'Vetor' na horizontal (sendo o espelho o eixo vertical). -}
-- <<http://oi63.tinypic.com/jhfx94.jpg inverteVetorH>> 
inverteVetorH :: Vetor -> Vetor
inverteVetorH (x,y) = (x,-y) 

{- | Função que dado um Vetor: Espelha um 'Vetor' na vertical (sendo o espelho o eixo horizontal). -}
-- <<http://oi68.tinypic.com/2n7fqxy.jpg inverteVetorV>>
inverteVetorV :: Vetor -> Vetor
inverteVetorV (x,y) = (-x,y) 


-- *** Funções do trabalho sobre 'Vetor'es.

{- | Função que dada uma Direcao: Devolve um 'Vetor' unitário (de comprimento 1) com a 'Direcao' dada. -}
direcaoParaVetor :: Direcao -> Vetor
direcaoParaVetor x | x == C = (-1,0)
                   | x == D = (0,1)
                   | x == B = (1,0)
                   | x == E = (0,-1)

-- ** Funções sobre listas

-- *** Funções gerais sobre listas.

-- Funções não disponíveis no 'Prelude', mas com grande utilidade.

{- | Função que dado um Int e uma Lista: Verifica se o indice pertence à lista. -}
eIndiceListaValido :: Int -> [a] -> Bool
eIndiceListaValido 0 [] = False
eIndiceListaValido a xs = (0 <= a) && (a <= (length xs-1))


-- ** Funções sobre matrizes.

-- *** Funções gerais sobre matrizes.

{- | Uma matriz é um conjunto de elementos a duas dimensões. -}

-- Em notação matemática, é geralmente representada por:
-- <<https://upload.wikimedia.org/wikipedia/commons/d/d8/Matriz_organizacao.png matriz>>
type Matriz a = [[a]]

{- | Função que dada uma Matriz: Calcula a dimensão de uma matriz. -}
dimensaoMatriz :: Matriz a -> Dimensao
dimensaoMatriz [] = (0,0)
dimensaoMatriz [[]] = (0,0)
dimensaoMatriz ([]:xs) = dimensaoMatriz xs
dimensaoMatriz m = (length m,length(head m))


{- | Função que dada uma Posicao e uma Matriz: Verifica se a posição pertence à matriz. -}
ePosicaoMatrizValida :: Posicao -> Matriz a -> Bool 
ePosicaoMatrizValida (l,c) [] = False
ePosicaoMatrizValida (l,c) m = (length m >= l) && (length (head m) >= c) && (l >= 0) && (c >= 0) 

{- | Funçaõ que dada uma Posicao e uma Matriz: Verifica se a posição está numa borda da matriz. -}
eBordaMatriz :: Posicao -> Matriz a -> Bool
eBordaMatriz(l,c) m = ( length m == (l+1) || l == 0 ) || (length (head m) == (c+1) || c == 0 ) 


-- *** Funções do trabalho sobre matrizes.

{- | Função que dado um Tetromino: Converte um 'Tetromino' (orientado para cima) numa 'Matriz' de 'Bool'. -}
-- <<http://oi68.tinypic.com/m8elc9.jpg tetrominos>>
tetrominoParaMatriz :: Tetromino -> Matriz Bool
tetrominoParaMatriz x | x == I = [[False,True,False,False],[False,True,False,False],[False,True,False,False],[False,True,False,False]] 
                      | x == J = [[False,True,False],[False,True,False],[True,True,False]]
                      | x == L = [[False,True,False],[False,True,False],[False,True,True]]
                      | x == O = [[True,True],[True,True]]
                      | x == S = [[False,True,True],[True,True,False],[False,False,False]]
                      | x == T = [[False,False,False],[True,True,True],[False,True,False]]
                      | x == Z = [[True,True,False],[False,True,True],[False,False,False]]

-- * Funções recursivas.

-- ** Funções sobre listas.

-- Funções não disponíveis no 'Prelude', mas com grande utilidade.

{- | Função que dado um Int e uma Lista: Devolve o elemento num dado índice de uma lista. -}
encontraIndiceLista :: Int -> [a] -> a
encontraIndiceLista x e = e!!x 

{- | Função que dado um Int, um elemento e uma Lista: Modifica um elemento num dado índice. -}
-- __NB:__ Devolve a própria lista se o elemento não existir.
atualizaIndiceLista :: Int -> a -> [a] -> [a]
atualizaIndiceLista x a [] = []
atualizaIndiceLista x a (y:ys) = if x == 0
                                 then a:ys
                                 else y:atualizaIndiceLista (x-1) a ys

-- ** Funções sobre matrizes.

{- | Função que dada uma Matriz: Roda uma 'Matriz' 90º no sentido dos ponteiros do relógio. -}
-- <<http://oi68.tinypic.com/21deluw.jpg rodaMatriz>>
rodaMatriz :: Matriz a -> Matriz a
rodaMatriz [] = []
rodaMatriz ([]:_) = []
rodaMatriz m = map head (reverse m) : rodaMatriz (map tail m)


{- | Função que dada um Matriz: Inverte uma 'Matriz' na horizontal. -}
-- <<http://oi64.tinypic.com/iwhm5u.jpg inverteMatrizH>>
inverteMatrizH :: Matriz a -> Matriz a
inverteMatrizH = map reverse 

{- | Função que dada uma Matriz: Inverte uma 'Matriz' na vertical. -}
-- <<http://oi64.tinypic.com/11l563p.jpg inverteMatrizV>>
inverteMatrizV :: Matriz a -> Matriz a
inverteMatrizV [] = []
inverteMatrizV (x:xs) = inverteMatrizV xs ++ [x]

{- | Função que dada uma Dimensao e um elemento: Cria uma nova 'Matriz' com o mesmo elemento. -}
criaMatriz :: Dimensao -> a -> Matriz a
criaMatriz (0,c) a = [] 
criaMatriz (l,0) a = []
criaMatriz (l,c) a = criaColuna (l,c) a : criaMatriz (l-1,c) a 

{- | Função que dada uma Dimensao e um elemento: Cria uma Lista com o mesmo elemento. -}
criaColuna :: Dimensao -> a -> [a]
criaColuna (l,0) a = []
criaColuna (0,c) a = [] 
criaColuna (l,c) a = a : criaColuna (l,c-1) a

{- | Função que dada uma Posicao e uma Matriz: Devolve o elemento numa dada 'Posicao' de uma 'Matriz'. -}

encontraPosicaoMatriz :: Posicao -> Matriz a -> a
encontraPosicaoMatriz (x,y) m = (m!!x) !! y 

{- | Função que dada uma Posicao, um elemento e uma Matriz: Modifica um elemento numa dada 'Posicao' -}
-- __NB:__ Devolve a própria 'Matriz' se o elemento não existir.
atualizaPosicaoMatriz :: Posicao -> a -> Matriz a -> Matriz a
atualizaPosicaoMatriz (l,c) e [] = []
atualizaPosicaoMatriz (l,c) e (x:xs) = if l==0
                                       then linhaNova (l,c) e (x:xs):xs
                                       else x:atualizaPosicaoMatriz (l-1,c) e xs 


{- | Função que dada uma Posicao, um elemento e uma Matriz: Substitui o elemento dando uma nova lista/linha -}
linhaNova :: Posicao -> a -> Matriz a -> [a]
linhaNova (l,c) e m = mudaElemL c e (buscaLinha l m)

{- | Função que dado um Int e uma Matriz: Vai buscar a linha à Matriz (1ª linha - linha 0) -}
buscaLinha :: Int -> Matriz a -> [a]
buscaLinha x [[]] = []
buscaLinha 0 (y:ys) = y
buscaLinha a (y:ys) = buscaLinha (a-1) ys


{- | Função que dado um Int, um elemnto e uma Lista: Muda o elemento (e) numa lista -}
mudaElemL :: Int -> a -> [a] -> [a]
mudaElemL c e (x:xs) = if c==0
                       then e:xs
                       else x:mudaElemL (c-1) e xs