#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CriaPasta
    4 – Escreva um programa que criará uma pasta
  com o nome “Lista 13” no rootpath
  (protheus_data) e copiará o arquivo do
  exercício 2 para essa pasta.
    @type  Function
    @author Giulliana Yamaguchi
    @since 24/04/2023
    /*/
User Function CopiaTXT()
    Local cOrigem := 'C:\Users\Giulliana Yamaguchi\AppData\Local\Temp\Lista 13–Ex2\'
    Local cDestin := '\lista 13\'

    //? Pegando os dados de todos os arquivos existentes dentro da pasta de origem
  Local aArquivos  := Directory(cOrigem + '*.*' /*Caminho + Tipos de Arquivos*/, 'D' /*Atribuos*/,/*Comp*/,/*Case Sensitive*/, 1 /*Ordenação dos arquivos*/)
  Local nI         := 0
  
  if LEN(aArquivos) > 0
    for nI := 3 to LEN(aArquivos)
      //? Copiando os arquivos da pasta de origem para a pasta de destino. 
      if !CpyT2S(cOrigem + aArquivos[nI][1], cDestin)      
        MsgStop('Houve um erro ao excluir o arquivo ' + aArquivos[nI][1])
      endif
    next
    FwAlertSuccess('Arquivo(s) copiado(s) com sucesso!', 'Concluído!')
  else
    FwAlertInfo('Apasta não contem nenhum arquivo!', 'Atenção!')
  endif
Return
