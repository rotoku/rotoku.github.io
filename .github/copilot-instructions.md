# Copilot Instructions
## Boas Práticas para GitHub Pages

1. **Organização do Repositório**:
   - Mantenha uma estrutura de diretórios clara e organizada.
   - Utilize um arquivo `README.md` para documentar o propósito do site e instruções de uso.

2. **Configuração do Tema**:
   - Certifique-se de que o tema Hugo está configurado corretamente no arquivo `config.toml` ou `config.yaml`.
   - Atualize o tema regularmente para obter correções de bugs e melhorias.

3. **Automação com GitHub Actions**:
   - Configure um workflow no GitHub Actions para automatizar a geração e publicação do site.
   - Certifique-se de que o workflow verifica erros antes de publicar.

4. **SEO e Acessibilidade**:
   - Adicione metadados no `head` para melhorar o SEO (títulos, descrições e palavras-chave).
   - Use ferramentas como Lighthouse para verificar a acessibilidade do site.

5. **Segurança**:
   - Evite expor informações sensíveis no repositório público.
   - Use HTTPS para garantir a segurança do site.

6. **Testes Locais**:
   - Teste o site localmente antes de fazer o push para o repositório.
   - Utilize o comando `hugo server` para verificar alterações em tempo real.

7. **Gerenciamento de Dependências**:
   - Liste dependências no arquivo `go.mod` (se aplicável) para facilitar a reprodução do ambiente.
   - Atualize dependências regularmente para evitar vulnerabilidades.

8. **Versionamento**:
   - Use branches para gerenciar alterações e revisões antes de mesclar na branch principal.
   - Utilize pull requests para revisão de código.

9. **Monitoramento e Logs**:
   - Configure ferramentas de monitoramento para acompanhar o desempenho do site.
   - Mantenha logs de erros para facilitar a depuração.

10. **Backup e Recuperação**:
    - Faça backups regulares do conteúdo e da configuração do site.
    - Utilize tags no Git para marcar versões estáveis.

Essas práticas ajudam a manter o site no GitHub Pages eficiente, seguro e fácil de gerenciar.