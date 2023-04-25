#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CriaPasta
  2 – Escreva um programa para criar um arquivo
  TXT com um texto qualquer e salvar dentro da
  pasta criada no exercício anterior.
    @type  Function
    @author Giulliana Yamaguchi
    @since 24/04/2023
    /*/
User Function EscrTXT()
  Local cPasta   := 'C:\Users\Giulliana Yamaguchi\AppData\Local\Temp\Lista 13–Ex2\'
  //? Definindo nome do arquivo como "TesteArq.txt" 
  Local cArquivo := 'Exerc1.txt'
  //? Instanciando a classe FWFileWriter (Responsável por criar o arquivo e escrever nele)
  Local oWriter  := FWFileWriter():New(cPasta + cArquivo, .T.)
  Local cTexto   := ''
    
  //? Verificando se o arquivo já existe na pasta
  if File(cPasta + cArquivo)
    FwAlertInfo('O arquivo já existe na pasta!', 'Atenção')
  else
    //? Caso não consiga criar o arquivo, a mensagem será apresentada
    if !oWriter:Create()
      FwAlertError('Houve um erro ao gerar o arquivo: ' + CRLF + oWriter:Error():Message, 'Atenção')
    else
         oWriter:Write('Olá!' + CRLF + 'Este é o exercício 2 da lista 13')
      //? Escrevendo no arquivo
      oWriter:Write(cTexto)
        
      //? Fechando o arquivo
      oWriter:Close()
        
      //? Perguntando se o usuário deseja abrir o arquivo criado
      if MsgYesNo('Arquivo gerado com sucesso (' + cPasta + cArquivo + ')!' + CRLF + 'Abrir arquivo?', 'Abrir?')
        ShellExecute('OPEN', cArquivo, '', cPasta, 1)
      endif
    endif
  endif
Return
