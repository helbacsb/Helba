//algoritmo para a comparação global 
//de 2 sequencias usando programação dinamica
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>  

/*funcoes principais de comparacao de sequencias */
void preencheMatrizS(char seq1[], char seq2[], int **S, int m, int n);
void alinhamento(int i,int j,int *tam,char seq1[],char seq2[],int **S,
    char alinhaS1[],char alinhaS2[]); //executa o alinhamento das duas sequencias (seq1,seq2) 

/*funcoes de pontuacao*/
int matchScore(char seq1, char seq2);
int gapScore();

/*funcao de alocacao dinamica da matriz de pontuacao S */
int **alocaMatrizPontuacao(int m, int n); 

/* funcoes de impressao */
void imprimeMatrizS(int **v, int m, int n);
void imprimeAlinhamento(char alinhaS1[], char alinhaS2[], int tam, int *alinhados);
void imprimeCaracteres(char alinhaS1[], char alinhaS2[], int ini, int fim, int *alinhados); /*funcao
    auxiliar para impressao do alinhamento imprime os caracteres |, . e espaço */

/* funcoes tratamento de arquivos */
int valida(FILE *arquivo); // verifica se o que tem no arquivo são nucleotídeos 
void contaSeq1Seq2(FILE *arquivo, int *contS1, int *contS2);//conta caracteres das seq 1,2 do arquivo
void montaVetor(FILE *arquivo, char seq1[], char seq2[]);//Coloca as 2 sequências em vetores

int main(){
   FILE *arq;     //declara um ponteiro de arquivo
   char *seq1;    //armazena a sequencia 1
   char *seq2;    //armazena a sequencia 2
   int contS1=0;  //Armazena o tamanho da sequência1
   int contS2=0;  //Armazena o tamanho da sequência2
   int **S;       //armazena a matriz de Pontuacao
   int tam;       //tamanho da sequencia com os gaps nos respectivos lugares
   char *alinhaS1;//Sequencia 1 com os gaps (alinhada com Sequencia 2)
   char *alinhaS2;//Sequencia 2 com os gaps (alinhada com Sequencia 1)
   int alinhados=0;
   
   arq = fopen("dna1.txt", "r");//abre o arquivo para leitura
   if(valida(arq)==0) //verifica se a sequencia é válida, se os caracteres sao nucleotideos
        printf("Sequencia invalida\n");
    else{
        rewind(arq); //recoloca o indicador de posição de arquivo do inicio do arquivo
        contaSeq1Seq2(arq, &contS1, &contS2);
        rewind(arq); //coloca o ponteiro no inicio do arquivo 
        seq1 = (char*)malloc(contS1*sizeof(char));
        seq2 = (char*)malloc(contS2*sizeof(char));
        montaVetor(arq, seq1,seq2);
        S = alocaMatrizPontuacao(contS1+1, contS2+1);
        preencheMatrizS(seq1, seq2, S, contS1+1,contS2+1);

        printf("\n\t\t\t ### PROGRAMA ALINHAMENTO ###  \n\n");
        printf("\nImprimindo a  pontuacao do melhor alinhamento: ");
        printf("%i\n\n", S[contS1][contS2]);
        printf("Tamanho da sequencia1 :%i ", contS1);
        printf("\n");
        printf("Tamanho da sequencia2 :%i \n", contS2);
        //imprimeMatrizS(S,contS1+1, contS2+1);
        printf("\n\n      ALINHANDO AS SEQUENCIAS:\n\n"); 
        alinhaS1 = (char*)malloc(contS1*sizeof(char));
        alinhaS2 = (char*)malloc(contS1*sizeof(char));
        alinhamento (contS1,contS2,&tam,seq1,seq2,S,alinhaS1,alinhaS2);
        imprimeAlinhamento(alinhaS1, alinhaS2,tam, &alinhados);
        printf("\n\nAlinhou %i nucleotideos \n",alinhados);
    }
    free(S); //liberando espaco na memoria...
    free(seq1);       free(seq2);
    free(alinhaS1);   free(alinhaS2);
    fclose(arq); //fechando arquivo  
    system("PAUSE");
    system("PAUSE");
    return 0; 
}

/****   Implementação das Funções   ****/
void preencheMatrizS(char seq1[], char seq2[], int **S, int m, int n){
   int i, j;
   int max; //maximo dos tres valores
   S[0][0]=0;
   for (j=1;j<n;j++)//preenche a coluna 0 da matriz
      S[0][j] = S[0][j-1] -2;
   for (i=1;i<m;i++)//preenche a linha 0 da matriz
      S[i][0] = S[i-1][0] -2;
   for (i=1;i<m;i++){  //constroi matriz S linha por linha
      for(j=1;j<n;j++){
         max=S[i-1][j] + gapScore();//inicializa max com o primeiro dos três termos
         if (max < (S[i][j-1]+ gapScore()))//verifica se o segundo termo é maior
            max = S[i][j-1]+ gapScore();
         if (max < (S[i-1][j-1] + matchScore(seq1[i-1],seq2[j-1])))//verifica se o terceiro termo é maior
            max=S[i-1][j-1]+ matchScore (seq1[i-1],seq2[j-1]);
         S[i][j]=max;
      }  
   }
}

void alinhamento(int i,int j,int *tam,char seq1[],char seq2[],int **S,char alinhaS1[],char alinhaS2[]){
//input: indices i, j , array a given by algorithm Similarity
//output: alignment in aligns1, aligns2, and tamgth in tam
   if ((i==0)&&(j==0))
       *tam=0;  
   else if ((i>0)&&(S[i][j]==S[i-1][j]+gapScore())) {
      alinhamento(i-1,j,tam,seq1,seq2,S,alinhaS1,alinhaS2);
      alinhaS1[*tam]=seq1[i-1];
      alinhaS2[*tam]='-';
      (*tam)++;
   }    
   else if ((i>0)&&(j>0)&&(S[i][j]==S[i-1][j-1]+ matchScore(seq1[i-1], seq2[j-1]))){
      alinhamento(i-1,j-1,tam,seq1,seq2,S,alinhaS1,alinhaS2);
      alinhaS1[*tam]=seq1[i-1];
      alinhaS2[*tam]=seq2[j-1];
      (*tam)++;
   }
   else{// if ((j>0)&&(S[i][j]==S[i][j-1] + gapScore())){
      alinhamento(i,j-1,tam,seq1,seq2,S,alinhaS1,alinhaS2);
      alinhaS1[*tam]='-';
      alinhaS2[*tam]=seq2[j-1];
      (*tam)++;
   }   
}

 
int matchScore(char seq1, char seq2){   
   if (seq1==seq2) 
      return 1;
   else 
      return -1; 
}

int gapScore (){
   return -2;
}

int **alocaMatrizPontuacao(int m, int n){
    int **v;   int   i; 
   /* aloca as linhas da matriz */
    v = (int **) malloc (m*sizeof(int*));
   /* aloca as colunas da matriz */
   for ( i = 0; i < m; i++ ) 
       v[i] = (int*) malloc (n*sizeof(int));
   return v;
}

void imprimeMatrizS(int **v, int m, int n){
    int i, j;
    for (i=0; i<m; i++) {
		for (j=0; j<n; j++) 
             printf("%d\t", v[i][j]);
        printf("\n");
   } 
}

void imprimeAlinhamento(char alinhaS1[], char alinhaS2[], int tam,int *alinhados){
   int i;
   //serão impressos 60 caracteres a cada linha das sequencias 
   if(tam<=70){   //caso em que a sequencia é menor que 60 caracteres
      for(i = 0;i<tam;i++)
        printf("%c", alinhaS1[i]);
        imprimeCaracteres(alinhaS1,alinhaS2,0,tam, alinhados); 
      for(i = 0;i<tam;i++)
         printf("%c", alinhaS2[i]);
      printf("\n\n");
   }
   else{  //sequencia onde há mais de 60 caracteres
      int lacos = tam/70;  //quantidade de laços que será impressa
      int resto = tam%70; //quantidade de caracteres restantes das sequencias
      int inc=0;  //faz o incremento da quantidade de laços feitos, vai até lacos
      int ini=0;  //valor inicial do laço
      int fim = 70; //valor final do laço 
      while(inc<lacos){
         for(i = ini;i<fim;i++)
            printf("%c", alinhaS1[i]);
            imprimeCaracteres(alinhaS1,alinhaS2, ini,fim, alinhados);
         for(i = ini;i<fim;i++)
            printf("%c", alinhaS2[i]);
         printf("\n\n\n");
         inc++;
         if(inc<lacos){ //os laços não chegaram ao fim
            ini = fim;  //muda a inicialização do laço
            fim +=70;   //muda a finalização do laço
         }
          
      }
      //se resto == 0, entao a nao há caracteres restantes a imprimir
      if(resto != 0){ //imprime os caracteres restantes
         for(i=fim;i<tam;i++)
            printf("%c", alinhaS1[i]);
         imprimeCaracteres(alinhaS1,alinhaS2, fim,tam, alinhados);
         for(i =fim;i<tam;i++)
            printf("%c", alinhaS2[i]);
         printf("\n");
   }
   }
}
void imprimeCaracteres(char alinhaS1[], char alinhaS2[], int ini, int fim, int *alinhados){
     int i;
     printf("\n");
     for(i=ini;i<fim;i++){
        if(alinhaS1[i]== alinhaS2[i]){
            printf("|");
            (*alinhados)++;
        }    
        else if((alinhaS1[i]=='-') || (alinhaS2[i]=='-'))
             printf(" ");
        else if(alinhaS1[i]!=alinhaS2[i])
             printf(".");
     }
     printf("\n");
}

/*A função valida verifica se as sequencias contem somente
os caracteres válidos, ou seja, A, C, T ou G.
O S é incluido pra sinalizar o inicio da segunda sequencia.*/

int valida(FILE *arquivo){
    char ch;
    int cont=0;
    int contn=0;
    while ((ch = getc(arquivo))!= EOF){
        ch = toupper(ch);
        if((ch!='A') && (ch!='C') && (ch!='T')&&(ch!='G')&&(ch!='S')&&(ch!='\n'))
            return 0;// Se diferente os caracteres não são nucleotideos
        if(ch=='S') cont++;//contando os S's da sequencia
        if(cont>1) return 0; //não pode haver mais de um S
    }
    return 1;
}
void contaSeq1Seq2(FILE *arquivo, int *contS1, int *contS2){//conta caracteres de um arquivo
    char ch;
    int contn1=0;
    int contn2=0;;
    while ((ch =(getc(arquivo)))!='S'){
        if(ch!='\n') (*contS1)++;
    }
    while ((ch = getc(arquivo)) != EOF){
        if(ch!='\n') (*contS2)++;
    }
}
void montaVetor(FILE *arquivo, char seq1[], char seq2[]){//Coloca as sequências em vetores
    char ch;
	int i=0,j=0;
    while ((ch = getc(arquivo)) != 'S'){
        if (ch != '\n') {
            seq1[i]=ch;
            i++;
        }
    }
    while ((ch = getc(arquivo)) != EOF){
        if (ch != '\n'){
            seq2[j]=ch;
            j++;
        }
    }
}



