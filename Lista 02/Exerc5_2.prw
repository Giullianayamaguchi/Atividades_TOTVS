
#include "Totvs.ch"
#Include "Tbiconn.ch"
 
//=================================================================================
/*/{Protheus.doc} zApiDol
Api | Cota��o do Dolar Ptax, Api Oficial do Banco Central
https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/documentacao
Api Dolar Ptax Banco Central x Advpl
/*/
//=================================================================================
User function CotaDolar()   
    Local aHeader     := {}
    Local cDataPtx    := ''//MM-DD-AAAA
    Local oJsObj      := JsonObject():New()
    Local cJsonRt     := ''
    Local oRestClient := FWRest():New("https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata")
    Local dDataBase := date()
    Local nCot        := 0
    Private nConv     := 0
    Private nDolar    := 0
    Private cMsg := ''
    //Cabe�alho
    aadd(aHeader,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')
    aAdd(aHeader,'Content-Type: application/json; charset=utf-8')
    //Ajusta Padr�o da Data para MM-DD-AAAA
    cDataPtx := Dtos(dDataBase-1)
    cDataPtx := SubStr(cDataPtx,5,2)+'-'+SubStr(cDataPtx,7,2)+'-'+SubStr(cDataPtx,1,4)
    
    //[GET] Consulta Dados na Api
    oRestClient:setPath("/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='"+cDataPtx+"'&$format=json")
    If oRestClient:Get(aHeader)
        //Grava Retorno
        cJsonRt := oJsObj:FromJson(oRestClient:CRESULT)
        //Exibe Cota��o
        If ValType(cJsonRt) == 'U'
            fViewCot(oJsObj)

             // solicitando informa��es ao usuario
    nDolar:= Val(FWInputbox("Digite a quantia de dolar com voc�: "))
    nCot  := Val(FWInputbox("Digite a cota��o para a convers�o"))
    nConv := nDolar * nCot

    cMsg += "<b>Convers�o do seu d�lar: $</b>" + str(NoRound(nConv,2))
    MsgInfo(cMsg,"Cota��o Dolar")

        Endif
        //Limpa Objeto
        FreeObj(oJsObj)
    Endif
     
    
RETURN

Static Function fViewCot(oJsObj)

    cMsg += "<b>Data:</b> "+Dtoc(Stod(StrTran(SubStr(oJsObj["value"][1]["dataHoraCotacao"],1,10),'-','')))
    cMsg += " - "+SubStr(oJsObj["value"][1]["dataHoraCotacao"],12,5)+"h<br>"
    cMsg += "<b>Cota��o do dolar: $</b> "+cValToChar(oJsObj["value"][1]["cotacaoCompra"])+"<br>"
    MsgInfo(cMsg,"Cota��o Dolar")
Return
