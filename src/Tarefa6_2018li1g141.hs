{-|
Module      : Tarefa6_2018li1g141
Description : Módulo para a criação de um robot capaz de jogar Tanks sozinho.
Copyright   : Paulo Barros <a67639@alunos.uminho.pt>;
              Leonardo Marreiros <a89537@alunos.uminho.pt>;

-}
module Tarefa6_2018li1g141 where

import LI11819
import Tarefa0_2018li1g141
import Tarefa1_2018li1g141
import Tarefa2_2018li1g141
import Tarefa4_2018li1g141
import Data.List



-- * Introdução 

-- *** O objectivo desta tarefa é implementar um jogador que jogue Tanks automaticamente. Apesar da estratégia de jogo adotada ficar ao critério de cada grupo de alunos, é importante que o bot tenha alguma "inteligência" de forma a tornar o jogo interessante para todos os jogadores. 
-- ***  Para a sua criação é importante ter em consideração os seguintes aspectos : 

-- *** 1º --> O bot recebe sempre um Estado de jogo válido de acordo com as tarefas anteriores.
-- *** 2º --> O objetivo do jogo é somar o maior número de pontos, sendo que por cada vez que atingimos um adversário ganhamos 4 pontos e 1 ponto por cada Bloco que seja destruído. No fim do jogo o jogador ganha também 4 pontos por cada vida que possua. 
-- *** 3º --> O jogo acaba passado 200 Ticks, ganhando o jogador com mais pontos somados, existindo a possibilidade de empates.
-- *** 4º --> Cada jogador começa com 6 vidas, 3 disparos do tipo laser e 3 disparos do tipo choque.



-- * Objetivos desta tarefa 

-- *** Para esta tarefa optamos começar por ver se não existe nenhuma bala em direção ao bot, isto para evitar que sejamos eliminados sem ripostar. Se existir vamos eliminar-la tentando ganhar vantagem, para isso quando o jogador tiver lasers dispara um de cada vez que houverem balas na sua direção, eliminando assim as balas que iam de encontro a si e aproveitando para atingir o adversario que as disparou. Acabando os lasers e continuando a existirem balas na sua direção, o bot vai responder sempre ás balas com outra bala, evitando assim ser atingido. 
-- *** Seguidamente vamos verificar se existe algum jogador na mesma linha ou na mesma coluna, se existir iremos procurar atingir-lo o máximo de vez possíveis, idealmente eliminando-o, ganhando assim pontos. É importante ir primeiro à procura dos jogadores não só porque assim se ganha mais pontos mas também para evitar que sejamos apanhados desprevinidos pelos adversários.
-- *** Por fim, se não tivermos jogadores em "linha de tiro" iremos fazer o mesmo mas desta vez procurando por Blocos Destrutiveis, sendo que o bot verifica quando blocos existem na linha e dispara apenas as balas necessárias, por exemplo, se tiver 5 blocos destrutíveis dispara 5 balas de canhão e vai continuar a ver no resto do mapa, tentanto assim destruir mais blocos de modo a ganhar ainda mais pontos. Se numa linha existirem mais que 8 blocos, optamos por disparar um laser de modo a eliminar tudo num tick, doutra maneira iriamos perder muito tempo. 
-- *** O objetivo será sempre eliminar o máximo de adversarios/blocos possíveis de modo a acumular o máximo de pontos que conseguirmos para ganhar cada partida que o bot disputar.

-- * Função principal da Tarefa 6.

-- | Define um ro'bot' capaz de jogar autonomamente o jogo. 
bot :: Int -- ^ O identificador do 'Jogador' associado ao ro'bot'.   
       -> Estado -- ^ O 'Estado' para o qual o ro'bot' deve tomar uma decisão.
       -> Maybe Jogada -- ^ Uma possível 'Jogada' a efetuar pelo ro'bot'.
bot i (Estado m js ds) | balasNaMinhaDirecao posJ dirJ ds && temLaser (encontraJogador i (Estado m js ds)) = Just (Dispara Laser)
                       | balasNaMinhaDirecao posJ dirJ ds && not (temLaser (encontraJogador i (Estado m js ds))) = Just (Dispara Canhao)
                       | jogEmLinhaDeTiro posJ dirJ (Estado m js ds) && blocosEmLinhadeTiro posJ dirJ m && temLaser (encontraJogador i (Estado m js ds)) = Just (Dispara Laser) 
                       | jogEmLinhaDeTiro posJ dirJ (Estado m js ds) && blocosEmLinhadeTiro posJ dirJ m && not (temLaser (encontraJogador i (Estado m js ds)))  = Just (Dispara Canhao)
                       | jogEmLinhaDeTiro posJ dirJ (Estado m js ds) && not (blocosEmLinhadeTiro posJ dirJ m) = Just (Dispara Canhao)
                       | jogEmLinhaDeTiro posJ (rodaDir dirJ) (Estado m js ds) = Just (Movimenta (rodaDir dirJ)) 
                       | jogEmLinhaDeTiro posJ (rodaXvezesDir 2 dirJ) (Estado m js ds) = Just (Movimenta (rodaXvezesDir 2 dirJ))
                       | jogEmLinhaDeTiro posJ (rodaXvezesDir 3 dirJ) (Estado m js ds) = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | nrBlocosLinha posJ dirJ m > 8 && temLaser (encontraJogador i (Estado m js ds)) = Just (Dispara Laser)
                       | nrBlocosLinha posJ dirJ m > disparosCaminhoBlocos posJ dirJ ds = Just (Dispara Canhao)
                       | nrBlocosLinha posJ dirJ m == disparosCaminhoBlocos posJ dirJ ds && blocosEmLinhadeTiro posJ (rodaDir dirJ) m = Just (Movimenta (rodaDir dirJ))
                       | nrBlocosLinha posJ dirJ m == disparosCaminhoBlocos posJ dirJ ds && blocosEmLinhadeTiro posJ (rodaXvezesDir 2 dirJ) m = Just (Movimenta (rodaXvezesDir 2 dirJ))
                       | nrBlocosLinha posJ dirJ m == disparosCaminhoBlocos posJ dirJ ds && blocosEmLinhadeTiro posJ (rodaXvezesDir 3 dirJ) m = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | nrBlocosLinha posJ dirJ m < disparosCaminhoBlocos posJ dirJ ds && blocosEmLinhadeTiro posJ (rodaDir dirJ) m = Just (Movimenta (rodaDir dirJ))
                       | nrBlocosLinha posJ dirJ m < disparosCaminhoBlocos posJ dirJ ds && blocosEmLinhadeTiro posJ (rodaXvezesDir 2 dirJ) m = Just (Movimenta (rodaXvezesDir 2 dirJ))
                       | nrBlocosLinha posJ dirJ m < disparosCaminhoBlocos posJ dirJ ds && blocosEmLinhadeTiro posJ (rodaXvezesDir 3 dirJ) m = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | pecaPosSeg == Vazia && pecaSegPosSeg == Vazia = Just (Movimenta dirJ)
                       | pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Bloco Indestrutivel && (pecaPosDir /= Bloco Indestrutivel && pecaPosSegDir /= Bloco Indestrutivel) = Just (Movimenta (rodaDir dirJ))
                       | pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Bloco Indestrutivel && (pecaPosEsq /= Bloco Indestrutivel && pecaPosSegEsq /= Bloco Indestrutivel) = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Bloco Indestrutivel && (pecaPosEsq == Bloco Indestrutivel || pecaPosSegEsq == Bloco Indestrutivel) = Just (Movimenta (rodaDir dirJ))
                       | pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Bloco Indestrutivel && (pecaPosDir == Bloco Indestrutivel || pecaPosSegDir == Bloco Indestrutivel) = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Bloco Destrutivel = Just (Dispara Canhao) 
                       | (dirJ == B || dirJ == E) && pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Vazia = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | (dirJ == B || dirJ == E) && pecaPosSeg == Vazia && pecaSegPosSeg == Bloco Indestrutivel = Just (Movimenta (rodaXvezesDir 1 dirJ))
                       | (dirJ == C || dirJ == D) && pecaPosSeg == Bloco Indestrutivel && pecaSegPosSeg == Vazia = Just (Movimenta (rodaXvezesDir 1 dirJ))
                       | (dirJ == C || dirJ == D) && pecaPosSeg == Vazia && pecaSegPosSeg == Bloco Indestrutivel = Just (Movimenta (rodaXvezesDir 3 dirJ))
                       | pecaPosSeg == Vazia && pecaSegPosSeg == Bloco Destrutivel = Just (Dispara Canhao) 
                       | otherwise = Just (Movimenta dirJ)
            where posJ = posJogInt i js
                  dirJ = dirJogInt i js
                  pecaPosSeg = encontraPosicaoMatriz (posSegDoJog posJ dirJ) m
                  pecaSegPosSeg = encontraPosicaoMatriz (segPosSegDoJog posJ dirJ) m 
                  pecaPosEsq = encontraPosicaoMatriz (posSegDoJog posJ (rodaXvezesDir 3 dirJ)) m
                  pecaPosSegEsq = encontraPosicaoMatriz (segPosSegDoJog posJ (rodaXvezesDir 3 dirJ)) m
                  pecaPosDir = encontraPosicaoMatriz (posSegDoJog posJ (rodaXvezesDir 1 dirJ)) m
                  pecaPosSegDir = encontraPosicaoMatriz (segPosSegDoJog posJ (rodaXvezesDir 1 dirJ)) m

-- *** Funções auxiliares para o funcionamento da função 'bot'.

-- | Dado um inteiro, identificador do 'Jogador' que coresponde ao 'bot' e uma lista de 'Jogador's dá a 'Posicao' do Bot.
-- Função necessária uma vez que só recebemos o identificador do 'Jogador' que iremos usar e o 'Estado' atual. 
posJogInt :: Int -- ^ Idenficador do 'Jogador' que o 'bot' controla.
             -> [Jogador] -- ^ Lista de 'Jogador'es.
             -> Posicao -- ^ 'Posicao' do 'bot'.
posJogInt i (Jogador p d v l c:js) = if i == 0 
                                     then p 
                                     else posJogInt (i-1) js                    

{- | Dado um inteiro, identificador do 'Jogador' que coresponde ao 'bot' e uma lista de 'Jogador's dá a 'Direcao' do Bot. -}
dirJogInt :: Int -- ^ Idenficador do 'Jogador' que o 'bot' controla.
             -> [Jogador] -- ^ Lista de 'Jogador'es.
             -> Direcao -- ^ 'Direcao' do 'bot'.
dirJogInt i (Jogador p d v l c:js) = if i == 0
                                    then d 
                                    else dirJogInt (i-1) js

{- | Recebendo uma 'Posicao', uma 'Direcao' e um 'Estado', verifica se existe algum 'Jogador' em linha de tiro, isto é, verifica se na sua 'Direcao' existe algum 'Jogador' que será atingido caso o 'bot' dispare, para isto não podem existir Blocos Indestrutíveis entre os Jogadores.
Esta função irá servir para o 'bot' decidir se vale a pena disparar um 'Canhao', um 'Laser' ou até mudar de 'Direcao' se tiver algum 'Jogador' que poderá ser atingido. Esta estratégia permite sermos ofensivos pois iremos estar sempre atentos as posições dos adversários mas também funciona da mesma maneira defensivamente pela mesma razão. 
-}
jogEmLinhaDeTiro :: Posicao -- ^ 'Posicao' do 'bot'.
                    -> Direcao -- ^ 'Direcao' do 'bot'.
                    -> Estado -- ^ 'Estado' atual.
                    -> Bool -- ^ Irá dar 'True' se existir um 'Jogador' em linha de tiro, 'False' se não existir. 
jogEmLinhaDeTiro p d (Estado m js ds) | encontraPosicaoMatriz (posSegDoJog p d) m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m /= Bloco Indestrutivel && not temJogVivo = jogEmLinhaDeTiro (posSeg p d) d (Estado m js ds)
                                      | encontraPosicaoMatriz (posSegDoJog p d) m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m /= Bloco Indestrutivel && temJogVivo = True
                                      | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Indestrutivel || encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Indestrutivel = False 
                                      | otherwise = False 
            where temJogVivo = posicoesNaLista [posSegDoJog p d,posSegDoJog p d] (posJogadoresVivos (Estado m js ds))
                 

aux :: Posicao -> Direcao -> Estado -> Int 
aux p d (Estado m js ds) | encontraPosicaoMatriz (posSegDoJog p d) m /= Bloco Indestrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m /= Bloco Indestrutivel = 1 + aux (posSeg p d) d (Estado m js ds)
                         | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Indestrutivel || encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Indestrutivel = 0 + aux (posSeg p d) d (Estado m js ds)
   
{- | Recebendo uma 'Posicao', uma 'Direcao' e um 'Mapa', verifica se existe algum 'Bloco Destrutivel' em linha de tiro, isto é, verifica se até ao próximo 'Bloco Indestrutivel' existe algum 'Bloco Destrutivel' para eliminar.
Esta função é parecida à 'jogEmLinhaDeTiro' mas neste caso vai procurar Blocos Destrutiveis, mudando de 'Direcao' se necessário de modo a destruir-los e obter pontos.
Primeiro iremos verificar se temos 'Jogador's perto e só depois Blocos Destruitiveis, por duas razões, primeiro porque obtemos mais pontos ao atingir um 'Jogador' e segundo porque se nos preocuparmos primeiramente com os Blocos corremos o risco de ser apanhados desprevenidos pelos adversários. 
-}
blocosEmLinhadeTiro :: Posicao -- ^ 'Posicao' do 'bot'.
                       -> Direcao -- ^ 'Direcao' do 'bot'. 
                       -> Mapa -- ^ 'Mapa' atual.
                       -> Bool -- ^ Irá dar 'True' se existir pelo menos um 'Bloco Destrutivel' em linha de tiro, 'False' se não existir nenhum. 
blocosEmLinhadeTiro p d m | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Destrutivel || encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Destrutivel = True
                          | encontraPosicaoMatriz (posSegDoJog p d) m == Vazia && encontraPosicaoMatriz (segPosSegDoJog p d) m == Vazia = blocosEmLinhadeTiro (posSeg p d) d m
                          | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Indestrutivel || encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Indestrutivel = False
                          | otherwise = False

nrBlocosLinha :: Posicao -> Direcao -> Mapa -> Int
nrBlocosLinha p d m | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Destrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Destrutivel = 1 + nrBlocosLinha (posSeg p d) d m
                    | encontraPosicaoMatriz (posSegDoJog p d) m == Vazia && encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Destrutivel = 1 + nrBlocosLinha (posSeg p d) d m
                    | encontraPosicaoMatriz (posSegDoJog p d) m == Vazia && encontraPosicaoMatriz (segPosSegDoJog p d) m == Vazia = 0 + nrBlocosLinha (posSeg p d) d m
                    | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Destrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m == Vazia = 1 + nrBlocosLinha (posSeg p d) d m
                    | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Destrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Indestrutivel = 1 
                    | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Indestrutivel && encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Destrutivel = 1 
                    | encontraPosicaoMatriz (posSegDoJog p d) m == Bloco Indestrutivel || encontraPosicaoMatriz (segPosSegDoJog p d) m == Bloco Indestrutivel = 0
                    | otherwise = 0 

disparosCaminhoBlocos :: Posicao -> Direcao -> [Disparo] -> Int
disparosCaminhoBlocos p d [] = 0 
disparosCaminhoBlocos (x0,y0) d (DisparoCanhao i (x,y) dir:ds) | d == C && x0 > x && y0 == y && dir == d = 1 + disparosCaminhoBlocos (x0,y0) d ds
                                                               | d == B && x0 < x && y0 == y && dir == d = 1 + disparosCaminhoBlocos (x0,y0) d ds
                                                               | d == E && x0 == x && y0 > y && dir == d = 1 + disparosCaminhoBlocos (x0,y0) d ds
                                                               | d == D && x0 == x && y0 < y && dir == d = 1 + disparosCaminhoBlocos (x0,y0) d ds
                                                               | otherwise = 0 + disparosCaminhoBlocos (x0,y0) d ds
disparosCaminhoBlocos p d (DisparoChoque i t :ds) = disparosCaminhoBlocos p d ds
disparosCaminhoBlocos p d (DisparoLaser i pos dir :ds) = disparosCaminhoBlocos p d ds


{- | Dada a 'Posicao' e a 'Direcao' de um 'Jogador', esta função irá calcular a 'Posicao' seguinte ao 'Jogador'. Função indicada para quando tratamos de um 'Jogador' porque a 'Posicao' dada nem sempre é a seguinte a (x,y), temos de ter em conta as 4 posições ocupadas pelo 'Jogador'. -}
posSegDoJog :: Posicao -- ^ 'Posicao' do 'Jogador'.
               -> Direcao -- ^ 'Direcao' do 'Jogador'.
               -> Posicao -- ^ 'Posicao' seguinte do 'Jogador'.
posSegDoJog (x,y) C = (x-1,y) 
posSegDoJog (x,y) E = (x,y-1)
posSegDoJog (x,y) B = (x+2,y)
posSegDoJog (x,y) D = (x,y+2)


{- | Dada a 'Posicao' e a 'Direcao' de um 'Jogador', esta função irá calcular a segunda 'Posicao' seguinte ao 'Jogador'. Função indicada para quando tratamos de um 'Jogador' porque a 'Posicao' dada nem sempre é a seguinte a (x,y), temos de ter em conta as 4 posições ocupadas pelo 'Jogador'. -}
segPosSegDoJog :: Posicao -- ^ 'Posicao' do 'Jogador'.
               -> Direcao -- ^ 'Direcao' do 'Jogador'.
               -> Posicao -- ^ Segunda 'posicao' que o 'Jogador' ocupará.
segPosSegDoJog (x,y) C = (x-1,y+1)
segPosSegDoJog (x,y) E = (x+1,y-1) 
segPosSegDoJog (x,y) B = (x+2,y+1)
segPosSegDoJog (x,y) D = (x+1,y+2)


{- | Dada a lista de 'Jogador's devolve apenas as posições dos 'Jogador's que ainda têm vidas. -}
posJogadoresVivos :: Estado -> [Posicao]
posJogadoresVivos (Estado m [] ds) = []
posJogadoresVivos (Estado m (Jogador (x,y) d v l c:js) ds) = if v > 0 
                                                             then (x,y):(x+1,y):(x+1,y+1):(x,y+1) : posJogadoresVivos (Estado m js ds) 
                                                             else posJogadoresVivos (Estado m js ds)


{- | Recebendo a 'Posicao' e a 'Direcao' do 'bot' juntamente com a lista de 'Disparo's, verifica se existe alguma 'Bala' na sua 'Direcao'. Para isso temos de ver se a 'Direcao' do 'Disparo' é contrária à 'Direcao' do 'bot' e se está em 'Direcao' a ele ou a "fugir" dele.
-}
balasNaMinhaDirecao :: Posicao -- ^ 'Posicao' do 'bot'.
                       -> Direcao -- ^ 'Direcao' do 'bot'.
                       -> [Disparo] -- ^ Lista de 'Disparo's atuais.
                       -> Bool -- ^ Irá dar 'True' se existir pelo menos uma 'Bala' em 'Direcao' ao 'bot', 'False' se não existir nenhuma. 
balasNaMinhaDirecao (x,y) dir [] = False
balasNaMinhaDirecao (x,y) dir (DisparoCanhao i (a,b) d:ds) | dir == C && x > a && y == b && d == B = True           
                                                           | dir == B && x < a && y == b && d == C = True
                                                           | dir == D && x == a && y < b && d == E = True
                                                           | dir == E && x == a && y > b && d == D = True
                                                           | otherwise = balasNaMinhaDirecao (x,y) dir ds 

balasNaMinhaDirecao (x,y) dir (DisparoLaser i (a,b) d:ds) = balasNaMinhaDirecao (x,y) dir ds 
balasNaMinhaDirecao (x,y) dir (DisparoChoque i t:ds) = balasNaMinhaDirecao (x,y) dir ds  

{- | Recebendo uma 'Direcao' dá o resultado de rodar a 'Direcao' para a direita uma vez. -}
rodaDir :: Direcao -- ^ 'Direcao' dada.
           -> Direcao -- ^ 'Direcao' resultante de rodarmos a 'Direcao' inicial para a direita uma vez.
rodaDir D = B
rodaDir B = E
rodaDir E = C
rodaDir C = D

{- | Função que recebendo um inteiro e uma 'Direcao' roda a 'Direcao' o número de vezes dadas pelo inteiro. -}
rodaXvezesDir :: Int -- ^ Número de vezes que iremos rodar a 'Direcao'.
                 -> Direcao -- ^ 'Direcao' dada.
                 -> Direcao -- ^ 'Direcao' resultante.
rodaXvezesDir 0 d = d
rodaXvezesDir i d = rodaXvezesDir (i-1) (rodaDir d)

-- * Conclusão 
-- *** Optando por uma estratégia um pouco ofensiva ao começar o jogo, normalmente conseguimos apanhar alguns jogadores preocupados apenas com uma zona de ação mais curta e assim ganhamos uma vantagem no confronto direto, tendo muitas vezes conseguido eliminar alguns adversarios evitando que o nosso jogador sofra muitos danos.
-- *** Evitamos gastar os disparos de laser com os blocos (usando apenas quando tem mais de 8 blocos na mesma linha) porque é uma arma importante no confronto com um jogador, sabendo que o adversário está a disparar sobre nós utilizamos o disparo de laser eliminando assim as balas do inimigo e retirando-lhe logo uma vida, ganhando assim uma vantagem sobre ele uma vez que as balas se destroiem entre si.
-- *** Optamos também por nunca usar o disparo de choque, tendo em conta a nossa estratégia não estávamos a conseguir tirar o melhor proveito da jogada, sendo que o adversario conseguia disparar retirando-nos vidas e ganhando assim uma vantagem sobre o nosso robot. 
-- *** Para concluir, embora seja uma tarefa acessível no início, por o bot a mexer-se e a disparar, para o fim começa a ser cada vez díficil mas também mais interessante arranjar novas maneiras de tentar ganhar os jogos.






