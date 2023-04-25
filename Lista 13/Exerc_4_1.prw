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
    User Function CriaPasta()
    Local cCaminho   := 'C:\PROTHEUS1212210\protheus_data\' //? Endereço onde a pasta será criada
    Local cNomePasta := 'Lista 13\' //? Nome da pasta que será criada
    
  //? Verificando se a pasta já existe
  if !ExistDir(cCaminho + cNomePasta)
    //? Criando a pasta
    if MakeDir(cCaminho + cNomePasta) == 0
      //? Chamando a função que criará um arquivo de texto dentro da pasta criada.

      if ExistBlock('CopiaTXT')
        ExecBlock('CopiaTXT', .F., .F., cCaminho + cNomePasta)
      endif
    else
      FwAlertError('Houve um erro ao criar a pasta ' + cNomePasta, 'Atenção')
    endif
  else
    if ExistBlock('CopiaTXT')
      ExecBlock('CopiaTXT', .F., .F., cCaminho + cNomePasta)
    endif
  endif
Return

