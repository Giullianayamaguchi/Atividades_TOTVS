#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function LerTXT
   3 � Desenvolva um programa para ler o texto do
    arquivo criado no exerc�cio anterior e
    apresent�-lo em uma mensagem para o usu�rio.
    @type  Function
    @author Giulliana Yamaguchi
    @since 24/04/2023
    /*/
User Function LerTXT()
    Local cPasta := 'C:\Users\Giulliana Yamaguchi\AppData\Local\Temp\lista 13�ex2\' //? Definindo a pasta onde o arquivo est�
    Local cArqu  := 'Exerc1.txt' //? Definindo nome do arquivo que ser� lido 
    Local oArq := FWFileReader():New(cPasta + cArqu)  //? Instanciando a classe FWFileReader (Respons�vel por ler o arquivo)

Local cText := ''
 
  //? Verificando de se o arquivo pode ser aberto
  if oArq:Open()
    //? Verificando se � o fim do arquivo. Se n�o for, entra no if
    if !oArq:EoF()
      //? Fazendo a leitura enquanto houverem linhas a serem lidas
      while (oArq:HasLine())
          //? Capturando o texto da linha atual
          cText += oArq:GetLine(.T.)
      enddo
    endif
     
    //? Fechando o arquivo (Isso indica o fim do processamento)
    oArq:Close()
  endif
  //? Apresentando texto do arquivo em uma mensagem
  FwALertInfo(cText, 'Conte�do do arquivo:')
Return

