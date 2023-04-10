#Include "protheus.ch"

/*/{Protheus.doc} MA410COR
    3 – Utilize um Ponto de Entrada para alterar as
legendas da rotina “Pedidos de Venda”.
As legendas devem utilizar as seguintes imagens:
o Pedido em aberto: “CHECKOK”
o Pedido encerrado: “BR_CANCEL”
o Pedido Liberado: “GCTPIMSE”
Após a alteração o browse dos pedidos de venda
devem ficar da seguinte forma:
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return aCoresPE, array, return_description
    @example
    (examples)
    @see https://tdn.totvs.com/display/public/PROT/FAT0121_Legendas_Status_do_Pedido_de_Vendas
    /*/
User Function MA410COR()

Local aCoresPE := {{"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ)", "CHECKOK", "Pedido de Venda em aberto"},;
{"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)", "BR_CANCEL", "Pedido de Venda encerrado"},;
{"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)", "GCTPIMSE", "Pedido de Venda liberado"}}

Return aCoresPE
