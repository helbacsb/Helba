/*---------------------------------------------------------------------
Inclusao de Bibliotecas
----------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

/******* Funcões Utilizadas     *********/

int valida(FILE *arquivo); // verifica se o que tem no arquivo são nucleotídeos 
void contaSeqPadrao(FILE *arquivo, int *contS, int *contP);//conta caracteres de um arquivo
void MontaVetor(FILE *arquivo, char vetSeq[], char vetPad[]);//Coloca a sequência e o padrão em vetores
void imprimeVetor(char vet[], int n);//utilizada para imprimir o vetor da sequência e do padrão
void funcaoPrefixo(int pi[], char p[], int tamP);/*encontra deslocamentos que
    podem ser seguramente descartados */
void KMP(char vetSeq[], char vetPad[],int pi[], int conts, int contp,
   int inx_desl[],int *cont_inx); /* KMP(s,p):recebe um texto s de n simbolos e
    um padrão p de m simbolos e realiza a comparação de s e p, devolvendo os 
    indices em s onde p ocorre.*/
void localizaPadrao(char vetSeq[], int conts, int inx_desl[],int *cont_inx);
   //localiza o padrão dentro da sequência


/******    funcao principal   ************/
int main(){
    FILE *arq;    //declara um ponteiro de arquivo
    char *vetSeq; //Armazena a sequencia neste vetor
    char *vetPad; //Armazena o padrao neste vetor 
    int *pi;      //Armazena o resultado do alinhamento do padrão com ele próprio
    int conts=0;  //Armazena o tamanho da sequência
    int contp=0;  //Armazena o tamanho do padrão
    //--------variaveis utilizadas nas funcoes KMP e localizaPadrao
    int inx_desl[10]; //perguntar 
    int cont_inx=0;   //perguntar ao Ivairton
    
    arq = fopen("dado.txt", "r");//abre o arquivo para leitura
    if(valida(arq)==0) //verifica se a sequencia é válida
        printf("Sequencia invalida\n");
    else{
        rewind(arq); //recoloca o indicador de posição de arquivo do inicio do arquivo
        contaSeqPadrao(arq, &conts, &contp);//chamando a função contaSeqPadrao
        rewind(arq); 
        vetSeq = (char*)malloc(conts*sizeof(char));
        vetPad = (char*)malloc(contp*sizeof(char));
        pi = (int*)malloc(contp*sizeof(int));
        MontaVetor(arq, vetSeq, vetPad);
        funcaoPrefixo(pi, vetPad, contp);
        printf("\t\t\t *****PROGRAMA BUSCA PADRAO******\n\n");
        printf("\nTamanho da sequencia : %d",conts);
        printf("\nTamanho do padrao    : %d",contp);
        printf("\n\nIMPRIMINDO PADRAO: \n");
        imprimeVetor(vetPad, contp);
         
        //funcao KMP 
        KMP(vetSeq, vetPad, pi,conts,contp, inx_desl, &cont_inx);

        //impressao considerando o deslocamento
        printf(" \n\nLocalizando o padrao na sequencia: \n\n");
        localizaPadrao(vetSeq, conts,inx_desl,&cont_inx);
     }
     printf("\n\n");
     fclose(arq);
     system("pause");
     return 0;
}
/*******funcoes utilizadas***********/
/*A função valida verifica se as sequencias contem somente
os caracteres válidos, ou seja, A, C, T ou G.
O P é incluido pra sinalizar o inicio do padrao.*/

int valida(FILE *arquivo){
    char ch;
    int cont=0;
    int contn=0;
    while ((ch = getc(arquivo))!= EOF){
        ch = toupper(ch);
        if((ch!='A') && (ch!='C') && (ch!='T')&&(ch!='G')&&(ch!='P')&&(ch!='\n'))
            return 0;// Se diferente os caracteres não são nucleotideos
        if(ch=='P') cont++;//contando os P's da sequencia
        if(cont>1) return 0; //não pode haver mais de um P
    }
    return 1;
}

void contaSeqPadrao(FILE *arquivo, int *contS, int *contP){
    char ch;
    int contn1=0;
    int contn2=0;;
    while ((ch =(getc(arquivo)))!='P'){
        if(ch!='\n') (*contS)++;
    }
    while ((ch = getc(arquivo)) != EOF){
        if(ch!='\n') (*contP)++;
    }
}

void MontaVetor(FILE *arquivo, char vetSeq[], char vetPad[]){
    char ch;
	int i=0,j=0;
    while ((ch = getc(arquivo)) != 'P'){
        if (ch != '\n') {
            vetSeq[i]=ch;
            i++;
        }
    }
    while ((ch = getc(arquivo)) != EOF){
        if (ch != '\n'){
            vetPad[j]=ch;
            j++;
        }
    }
}
void imprimeVetor(char vet[], int n){
     int i;
     for(i=0;i<n;i++)
         printf("%c", vet[i]);
     printf("\n");
}    
//FunçãoPrefixo(p) recebe uma sequência p de m símbolos e devolve a função prefixo 'pi' para p.
void funcaoPrefixo(int pi[], char p[], int tamP){
    int k=0;
    int q;
    pi[0]=0;
    for(q=1; q<tamP ;q++){
       while(k>0 && (p[k]!= p[q])) k=pi[k-1];
           if(p[k]==p[q]) k++;  //para os casos que não se encaixam na condição do while
           pi[q]=k;
       }
}

void KMP(char vetSeq[], char vetPad[],int pi[], int conts, int contp, int inx_desl[],int *cont_inx){
    int i, q=0;
    for(i=0; i< conts; i++){
    while(q>0 && (vetPad[q]!=vetSeq[i]))     q=pi[q-1];
        if(vetPad[q]==vetSeq[i])    q++;
            if(q==contp){
                printf("\nPadrao ocorre no texto com deslocamento: %i\n",(i-contp)+1);
                inx_desl[*cont_inx]=(i-contp)+1;
                (*cont_inx)++;
                q=pi[q-1];
            }
        }
}

void localizaPadrao(char vetSeq[], int conts, int inx_desl[],int *cont_inx){
    int i, aux_inx=0;
    int cont_padrao=0;
    for(i=0;i<conts;i++) {
        if(aux_inx < *cont_inx) {
            if(inx_desl[aux_inx] == i) {
                printf("_");
                cont_padrao++;
                printf("%c",vetSeq[i]);
                aux_inx++;
            }
            else
                printf("%c",vetSeq[i]);  
        }
        else
            printf("%c",vetSeq[i]);
    }
    printf("\n\n\nPadrao ocorre %i vezes na sequencia\n\n", cont_padrao);
}
