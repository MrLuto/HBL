
Set-Mailbox -Identity verkoop@perfectkeur.nl -GrantSendOnBehalfTo @{Add="A.Soffree@perfectkeur.nl","H.huisman@perfectkeur.nl","i.hoogerdijk@perfectkeur.nl","l.desmit@perfectkeur.nl","mm.vanderheide@perfectkeur.nl","s.hagoort@perfectkeur.nl","t.westerink@perfectkeur.nl"}


Get-Mailbox -Identity verkoop@perfectkeur.nl | Format-List GrantSendOnBehalfTo

