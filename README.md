# PriseScanner
iOS Приложение для распознавания названия и цены товара на ценнике.

![app icon](https://github.com/chausovSurfStudio/PriceScanner/blob/master/PriceScanner/Resourses/Assets.xcassets/AppIcon.appiconset/Icon.png)


## Что необходимо, чтобы запустить проект

---


### В проекте используются cocoapods версии 1.4.0 и выше
Для просмотра текущей версии:
> pod --version
Для обновления:
> sudo gem install cocoapods

---

### Также необходим gem ruby версии 2.4.0
[Если необходимо обновить - см. сюда](https://stackoverflow.com/questions/38194032/how-to-update-ruby-version-2-0-0-to-the-latest-version-in-mac-osx-yosemite)

---

### Для генерации модулей используется generamba
Для установки генерамбы:
> gem install generamba

---

### Также, существует отдельный target с OCLint (статический анализатор кода)
Для его установки необходимо:
> brew tap oclint/formulae
> brew install oclint
[Более подробная документация](http://oclint-docs.readthedocs.io/en/stable/intro/homebrew.html)

---

### Если в процессе установки OCLint возникают ошибки
К примеру, может возникнуть такой кейс:
> xcodebuild -list
> xcode-select: error: tool 'xcodebuild' requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance
В этом случае необходимо:
> xcode-select --install
> sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
[Более подробно вопрос освещен здесь](https://github.com/nodejs/node-gyp/issues/569)