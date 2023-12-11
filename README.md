# popup-lov-multiple-values
Esse bloco PL/SQL estar sendo usado em um aplicativo APEX (Oracle Application Express) para inserir dados em duas tabelas relacionadas, `GC_ALUNOS` e `GC_CURSO_DESEJADO`, em uma operação de uma página.

Vou explicar o que esse bloco PL/SQL está fazendo:

1. **Declaração de Variáveis:**
    ```plsql
    DECLARE
        v_ID_ALUNO NUMBER;
        l_values_array APEX_APPLICATION_GLOBAL.VC_ARR2;
    BEGIN
    ```
    Aqui, são declaradas duas variáveis: `v_ID_ALUNO` para armazenar o ID do aluno inserido e `l_values_array` para armazenar um array de valores.

2. **Inserção na Tabela `GC_ALUNOS`:**
    ```plsql
    INSERT INTO GC_ALUNOS (
        NOME_ALUNOS
    ) VALUES (
        :P11_NOME_ALUNOS
    ) RETURNING ID_ALUNOS INTO v_ID_ALUNO;
    ```
    Essa parte insere um novo registro na tabela `GC_ALUNOS` com o nome do aluno proveniente do item de página `P11_NOME_ALUNOS` e recupera o ID recém-inserido na variável `v_ID_ALUNO` usando a cláusula `RETURNING INTO`.

3. **Tratamento de Cursos Desejados:**
    ```plsql
    l_values_array := APEX_STRING.STRING_TO_TABLE(:P11_CURSOS, ':');
    FOR i IN 1 .. l_values_array.COUNT LOOP
        INSERT INTO GC_CURSO_DESEJADO (FK_ALUNO, FK_CURSO) VALUES (v_ID_ALUNO, l_values_array(i));
    END LOOP;
    ```
    Nessa parte, a função `STRING_TO_TABLE` é usada para converter a string de cursos `:P11_CURSOS` em um array usando `':'` como delimitador. Em seguida, um loop `FOR` é usado para iterar sobre o array e inserir registros correspondentes na tabela `GC_CURSO_DESEJADO` associados ao aluno recém-inserido.

4. **Fim do Bloco PL/SQL:**
    ```plsql
    END;
    ```
    O bloco PL/SQL é encerrado.

Esse bloco é útil para inserir um novo aluno e seus cursos desejados nas tabelas mencionadas.
