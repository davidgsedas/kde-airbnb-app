#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <sstream>
#include <iomanip>

using namespace std;

// Función para calcular KDE Gaussiano
vector<double> kdeGaussiano(const vector<double>& x, const vector<double>& data, double bandwidth) {
    int n = x.size();
    int m = data.size();
    vector<double> output(n);

    for (int i = 0; i < n; i++) {
        double sum = 0;
        for (int j = 0; j < m; j++) {
            double u = (x[i] - data[j]) / bandwidth;
            sum += exp(-0.5 * u * u) / sqrt(2 * M_PI);
        }
        output[i] = sum / (m * bandwidth);
    }

    return output;
}

int main() {
    const string inputFileName = "airbnb.csv";
    const string outputFileName = "airbnb_result.csv";
    const double bandwidth = 0.1;  // Ajusta el ancho de banda según tus necesidades

    ifstream inputFile(inputFileName);
    ofstream outputFile(outputFileName);

    if (!inputFile) {
        cerr << "Error al abrir el archivo " << inputFileName << endl;
        return 1;
    }

    // Leer los datos del archivo CSV
    vector<double> latitudes;
    vector<double> longitudes;
    string line;

    while (getline(inputFile, line)) {
        istringstream iss(line);
        double latitude, longitude;
        char comma;
        iss >> latitude >> comma >> longitude;
        latitudes.push_back(latitude);
        longitudes.push_back(longitude);
    }

    // Aplicar el análisis KDE a las latitudes
    vector<double> kdeLatitudes = kdeGaussiano(latitudes, latitudes, bandwidth);

    // Escribir los resultados en el archivo de salida
    for (int i = 0; i < latitudes.size(); i++) {
        outputFile << fixed << setprecision(6) << latitudes[i] << "," << longitudes[i] << "," << kdeLatitudes[i] << endl;
    }

    cout << "Proceso completado. Resultados almacenados en " << outputFileName << endl;

    inputFile.close();
    outputFile.close();

    return 0;
}
