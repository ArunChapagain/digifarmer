const String newsAPIBaseURL = 'https://newsapi.org/v2';
const String newsAPIKey = '38b9158802a34f9ca21dcff1d5c3a87f';
const String newsAPIEndPoint = '/everything';
// const String newsAPIQuery = 'q=farmers&sortBy=popularity';

const String weatherAPIKey = '73f49df9790a4edabce175946242105';
const String weatherAPIBaseURL = 'https://api.weatherapi.com/v1';
const String weatherAPIEndPoint = '/forecast.json';

// Gemini API Configuration
const String geminiAPIKey =
    'AIzaSyAhn6EvgCPWag5KHZHggNW1AS5LmVT9ul8'; // Replace with your actual Gemini API key
const String geminiAPIBaseURL =
    'https://generativelanguage.googleapis.com/v1beta';
const String geminiAPIEndPoint = '/models/gemini-pro:generateContent';

//https://newsapi.org/v2/everything?q=farmers&sortBy=popularity&apiKey=e13c1810209a4e6ca7997d39b797152c

//model
String tomatoDiseaseModel = "assets/model/disease/tomato.tflite";
String tomatoDiseasetxt = "assets/model/disease/tomatolabels.txt";

String riceDiseaseModel = "assets/model/disease/rice.tflite";
String riceDiseasetxt = "assets/model/disease/ricelabels.txt";

String wheatDiseaseModel = "assets/model/disease/wheat.tflite";
String wheatDiseasetxt = "assets/model/disease/wheatlabels.txt";

String cornDiseaseModel = "assets/model/disease/corn.tflite";
String cornDiseasetxt = "assets/model/disease/cornlabels.txt";

String sugarcaneDiseaseModel = "assets/model/disease/sugarcane.tflite";
String sugarcaneDiseasetxt = "assets/model/disease/sugarcanelabels.txt";

String cottonDiseaseModel = "assets/model/disease/cotton.tflite";
String cottonDiseasetxt = "assets/model/disease/cottonlabels.txt";

String plantHealthModel = "assets/model/disease/plant_health.tflite";
String plantHealthtxt = "assets/model/disease/plant_health_labels.txt";

String maizeDiseasesModel = 'assets/model/disease/maize_disease_model.tflite';
String maizeDiseasestxt = 'assets/model/disease/maize_disease_labels.txt';
