# AI-Translate
Cross platform tool to translate between over 100 world languages using GPT-3.5, GPT-4, and Vicuna-13b.

Language Models supported:
* vicuna-13b
* gpt-4 - OpenAI
* gpt-4-0613 - OpenAI
* gpt-4-32k - OpenAI
* gpt-4-32k-0613 - OpenAI
* gpt-3.5-turbo - OpenAI
* gpt-3.5-turbo-16k - OpenAI
* llama70b-v2-chat
* llama13b-v2-chat
* falcon-40b-instruct

Built with [Delphi](https://www.embarcadero.com/products/delphi/) using the FireMonkey framework this client works on Windows, macOS, and Linux (and maybe Android+iOS) with a single codebase and single UI. At the moment it is specifically set up for Windows.

It features a REST integration with Replicate.com and OpenAI for providing generative text functionality within the client. You need to sign up for an API keys to access that functionality. Replicate models can be run in the cloud or locally via docker.

```
docker run -d -p 5000:5000 --gpus=all r8.im/replicate/vicuna-13b@sha256:6282abe6a492de4145d7bb601023762212f9ddbbe78278bd6771c8b3b2f2a13b
curl http://localhost:5000/predictions -X POST -H "Content-Type: application/json" \
  -d '{"input": {
    "prompt": "...",
    "max_length": "...",
    "temperature": "...",
    "top_p": "...",
    "repetition_penalty": "...",
    "seed": "...",
    "debug": "..."
  }}'
```

World Languages supported:
* Afrikaans
* Albanian
* Amharic
* Arabic
* Armenian
* Azerbaijani
* Basque
* Belarusian
* Bengali
* Bosnian
* Bulgarian
* Catalan
* Cebuano
* Chichewa
* Chinese (Simplified)
* Chinese (Traditional)
* Corsican
* Croatian
* Czech
* Danish
* Dutch
* English
* Esperanto
* Estonian
* Filipino
* Finnish
* French
* Frisian
* Galician
* Georgian
* German
* Greek
* Gujarati
* Haitian Creole
* Hausa
* Hawaiian
* Hebrew
* Hindi
* Hmong
* Hungarian
* Icelandic
* Igbo
* Indonesian
* Irish
* Italian
* Japanese
* Javanese
* Kannada
* Kazakh
* Khmer
* Kinyarwanda
* Korean
* Kurdish (Kurmanji)
* Kyrgyz
* Lao
* Latin
* Latvian
* Lithuanian
* Luxembourgish
* Macedonian
* Malagasy
* Malay
* Malayalam
* Maltese
* Maori
* Marathi
* Mongolian
* Myanmar (Burmese)
* Nepali
* Norwegian
* Odia (Oriya)
* Pashto
* Persian
* Polish
* Portuguese
* Punjabi
* Romanian
* Russian
* Samoan
* Scots Gaelic
* Serbian
* Sesotho
* Shona
* Sindhi
* Sinhala
* Slovak
* Slovenian
* Somali
* Spanish
* Sundanese
* Swahili
* Swedish
* Tajik
* Tamil
* Tatar
* Telugu
* Thai
* Turkish
* Turkmen
* Ukrainian
* Urdu
* Uyghur
* Uzbek
* Vietnamese
* Welsh
* Xhosa
* Yiddish
* Yoruba
* Zulu

# AI Translate Desktop client Screeshot on Windows
![AI Translate Desktop client on Windows](/screenshot.png)

# AI ToolKit

[Stable Diffusion Desktop Client](https://github.com/FMXExpress/Stable-Diffusion-Desktop-Client)

[CodeDroidAI](https://github.com/FMXExpress/CodeDroidAI)

[ControlNet Sketch To Image](https://github.com/FMXExpress/ControlNet-Sketch-To-Image)

[AutoBlogAI](https://github.com/FMXExpress/AutoBlogAI)

[AI Code Translator](https://github.com/FMXExpress/AI-Code-Translator)

[AI Playground](https://github.com/FMXExpress/AI-Playground-DesktopClient)

[Song Writer AI](https://github.com/FMXExpress/Song-Writer-AI)

[Stable Diffusion Text To Image Prompts](https://github.com/FMXExpress/Stable-Diffusion-Text-To-Image-Prompts)

[Generative AI Prompts](https://github.com/FMXExpress/Generative-AI-Prompts)

[Dreambooth Desktop Client](https://github.com/FMXExpress/DreamBooth-Desktop-Client)

[Text To Vector Desktop Client](https://github.com/FMXExpress/Text-To-Vector-Desktop-Client)
