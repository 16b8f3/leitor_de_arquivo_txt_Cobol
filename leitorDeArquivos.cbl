      ******************************************************************
      * Author: Gildo
      * Date: 14 de Maio de 2022
      * Purpose: Ler arquivos .txt
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEITOR-DE-TXT.
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      * PARA COLOCAR OUTRO ARQUIVO ALTERE O NOME E COLOQUE O NOVO ARQUIVO NA
      * PASTA bin
            SELECT IN-FILE ASSIGN TO "campeosDoLol.txt"
                ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.

       FD IN-FILE.
       01 IN-RECORD.
           05 CHAMPION-NAME        PIC X(15).

       WORKING-STORAGE SECTION.

       01 SWITCHES.
           05 EOF-SWITCH           PIC X VALUE "N".

       01 COUNTERS.
           05 REC-COUNTER          PIC 9(3) VALUE 0.

       PROCEDURE DIVISION.

       000-MAIN.
            PERFORM 100-INITIALIZE.
            PERFORM 200-PROCESS-RECORDS
                UNTIL EOF-SWITCH = "Y".
            PERFORM 300-TERMINATE.
            STOP RUN.

       100-INITIALIZE.

           OPEN INPUT IN-FILE.

           READ IN-FILE
               AT END
                   MOVE "Y" TO EOF-SWITCH
              NOT AT END
                  COMPUTE REC-COUNTER = REC-COUNTER + 1
           END-READ.

       200-PROCESS-RECORDS.

           DISPLAY "NAME OF CHAMPION - " CHAMPION-NAME.

           READ IN-FILE
               AT END
                   MOVE "Y" TO EOF-SWITCH
               NOT AT END
                   COMPUTE REC-COUNTER = REC-COUNTER + 1
           END-READ.

       300-TERMINATE.

      * NAO CONSEGUI ACHAR EQUIVALENTE DE \N EM COBOL.
           DISPLAY "".
           DISPLAY "FINAL COUNTER NUMBER >>> " REC-COUNTER.
           CLOSE IN-FILE.

       MAIN-PROCEDURE.
      * QUANDO PASSEI O QUE ESTAVA NO '000-MAIN.' PARA O 'MAIN-PROCEDURE.'
      * O CODIGO COMECOU A TER O COMPORTAMENTO INESPERADO DE CONTAR ALGUMAS
      * LINHAS MAIS VEZES, LEVANDO O REC-COUNTER DE 159 (VALOR CORRETO) PARA
      * 161

       END PROGRAM LEITOR-DE-TXT.
