import SwiftUI
import Speech

class SpeechRecognizer: NSObject, ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    var wordsToRecognize: [String]
    
    @Published var recognizedText = ""
    @Published var isRecording = false
    @Published var userAnswers = [String: Bool]()
    
    init(wordsToRecognize: [String]) {
        self.wordsToRecognize = wordsToRecognize
        super.init()
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus != .authorized {
                    print("Speech recognition not authorized")
                }
            }
        }
    }
    
    func startRecording() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .measurement, options: [])
            try session.setActive(true, options: .notifyOthersOnDeactivation)
            let inputNode = audioEngine.inputNode
            let format = inputNode.outputFormat(forBus: 0)
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create recognition request") }
            recognitionRequest.shouldReportPartialResults = true
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { [weak self] result, error in
                guard let self = self else { return }
                if let result = result {
                    self.recognizedText = result.bestTranscription.formattedString
                    self.checkAnswer(for: result.bestTranscription.formattedString)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            })
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true
        } catch {
            print("Error starting recognition: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        isRecording = false
    }
    
    private func checkAnswer(for word: String) {
        if let index = wordsToRecognize.firstIndex(of: word) {
            userAnswers[word] = true
            wordsToRecognize.remove(at: index)
        }
    }
}
