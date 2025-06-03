import os
import glob

def remove_robot_screenshots():
    # Padrões de arquivos para procurar
    patterns = [
        "selenium-screenshot-*.png",  # Screenshots do Selenium
        "*.png"  # Outros screenshots que possam ter sido gerados
    ]
    
    # Contador de arquivos removidos
    total_removidos = 0
    
    # Percorre todos os diretórios e subdiretórios
    for root, dirs, files in os.walk("."):
        for pattern in patterns:
            # Caminho completo para o padrão de arquivo
            path_pattern = os.path.join(root, pattern)
            
            # Encontra todos os arquivos que correspondem ao padrão
            for arquivo in glob.glob(path_pattern):
                try:
                    os.remove(arquivo)
                    print(f"Arquivo removido: {arquivo}")
                    total_removidos += 1
                except Exception as e:
                    print(f"Erro ao remover {arquivo}: {str(e)}")
    
    print(f"\nTotal de arquivos removidos: {total_removidos}")

if __name__ == "__main__":
    print("Iniciando remoção de screenshots...")
    remove_robot_screenshots()
    print("Processo finalizado!") 