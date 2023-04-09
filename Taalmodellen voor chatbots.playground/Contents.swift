import UIKit
import Foundation

func getNGrams(n: Int, text: String) -> [String] {
    var cleanedText = text.lowercased().replacingOccurrences(of: "[^a-z\\s]", with: "", options: .regularExpression)
    let words = cleanedText.components(separatedBy: .whitespacesAndNewlines)
    var ngrams = [String]()
    for i in 0..<(words.count - n + 1) {
        let ngram = words[i..<i+n].joined(separator: " ")
        ngrams.append(ngram)
    }
    return ngrams
}


func buildFrequencyTable(ngrams: [String]) -> [String:Int] {
    var frequencyTable = [String:Int]()
    for ngram in ngrams {
        // als er een dubbele is wordt er opgeteld
        frequencyTable[ngram, default: 0] += 1
    }
    return frequencyTable
}

func predictNextWord(ngram: String, frequencyTable: [String:Int]) -> String? {
    let words = ngram
    let nextWords = frequencyTable.filter { $0.key.hasPrefix("\(words) ") }
                                   .sorted { $0.value > $1.value }
    return nextWords.first?.key.components(separatedBy: " ").last
}

func generateSentence(ngram: String, frequencyTable: [String:Int], words: Int) -> String? {
    var sentence = ngram
    let n = ngram.components(separatedBy: " ").count
    for _ in 0..<(words) {
        var ngramWords = getWordsByNgram(sentence: sentence, n: n) // pak de laatste 2 of 3 van de complete zin
        if let nextWord = predictNextWord(ngram: ngramWords, frequencyTable: frequencyTable) {
            sentence += " \(nextWord)"
        } else {
            break
        }
    }

    return sentence
}

func getWordsByNgram(sentence: String, n: Int) -> String {
    let words = sentence.components(separatedBy: " ")
    let lastWords = words.suffix(n)
    let result = lastWords.joined(separator: " ")
    return result
}

var text = "Er waren eens twee vogels genaamd Blue en Jay. Ze waren de beste vrienden en de meest avontuurlijke vogels van het bos. Op een dag, terwijl ze aan het genieten waren van de zonsondergang, merkten ze op dat de maan helderder en groter was dan normaal. Blue en Jay keken elkaar aan en wisten meteen wat ze wilden doen. Ze wilden naar de maan vliegen!Blue en Jay begonnen hun reis voor te bereiden. Ze verzamelden informatie over hoe ze naar de maan konden vliegen en wat ze nodig hadden om de reis te volbrengen. Ze lazen boeken, spraken met andere dieren en zochten het internet af. Uiteindelijk kwamen ze erachter dat ze een speciaal soort brandstof nodig hadden om hun reis te maken.Het vinden van de juiste brandstof was niet makkelijk, maar uiteindelijk vonden ze een magisch kruid genaamd 'Moonleaf'. Dit kruid zou hen genoeg energie geven om naar de maan te vliegen en terug te keren. Blue en Jay plukten het kruid en gingen aan de slag met het maken van hun brandstof.Nadat ze hun brandstof hadden gemaakt, bouwden ze een ruimteschip. Het duurde een paar dagen om het ruimteschip te bouwen, maar ze waren vastberaden om hun doel te bereiken. Toen het ruimteschip klaar was, testten ze het uit en stelden ze de juiste coördinaten in om naar de maan te vliegen.De nacht van de reis naar de maan was aangebroken. Blue en Jay stapten in het ruimteschip en staken de motor aan. Met een luid gebrul begon het ruimteschip de lucht in te stijgen. Terwijl ze hoger en hoger vlogen, zagen ze de aarde steeds kleiner worden. Het was een geweldig gevoel om zo hoog in de lucht te zijn.Na een paar uur vliegen bereikten ze de maan. Het was een prachtig gezicht om de maan van zo dichtbij te zien. Blue en Jay konden niet wachten om te landen en de maan te verkennen. Ze vonden een plek om te landen en stapten uit het ruimteschip.Het was anders dan alles wat ze ooit hadden gezien. De grond was bedekt met fijn maanstof en er waren geen bomen of planten. Ze konden de aarde zien vanaf de maan en het was een indrukwekkend gezicht. Ze vlogen zelfs nog hoger om een beter uitzicht te krijgen.Terwijl ze aan het verkennen waren, kwamen ze een maanrover tegen die de NASA had achtergelaten. Blue en Jay gingen aan boord en ontdekten de fascinerende technologie die erin zat. Ze speelden ermee en vonden het geweldig. Het was een hele ervaring om op de maan te zijn en ze wisten dat ze het nooit zouden vergeten."

//text = "dit is een test en dit is ook een korte zin want dit is ook een demo voor een test van de assessment"
let input = "blue en jay"
let n = input.components(separatedBy: " ").count + 1
let ngrams = getNGrams(n: n, text: text)
let frequencyTable = buildFrequencyTable(ngrams: ngrams) // dit moet nog updaten want ja zin wordt groter?

//let predictedNextWord = predictNextWord(ngram: input, frequencyTable: frequencyTable)
let sentence = generateSentence(ngram: input, frequencyTable: frequencyTable, words: 20)

print(sentence)



