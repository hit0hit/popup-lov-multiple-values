DECLARE
v_ID_ALUNO NUMBER;
l_values_array APEX_APPLICATION_GLOBAL.VC_ARR2;
BEGIN
INSERT INTO GC_ALUNOS (
       NOME_ALUNOS,
) VALUES (
    :P11_NOME_ALUNOS,
)RETURNING ID_ALUNOS INTO v_ID_ALUNO;


l_values_array := APEX_STRING.STRING_TO_TABLE(:P11_CURSOS, ':');
FOR i IN 1 .. l_values_array.COUNT LOOP
    insert into GC_CURSO_DESEJADO (FK_ALUNO,FK_CURSO) VALUES (v_ID_ALUNO, l_values_array(i));
END LOOP;

END;
