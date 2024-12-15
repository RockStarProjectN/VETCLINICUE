//
//  LoginView.swift
//  AnimalApp
//
//  Created by Ilya Rychkov on 05.12.2024.
//

import SwiftUI

// Экран входа в систему
struct LoginView: View {
    @State private var username: String = "" // Поле для ввода логина
    @State private var password: String = "" // Поле для ввода пароля
    @State private var isLoggedIn = false // Состояние авторизации

    var body: some View {
        NavigationStack {
            ZStack {
                // Градиентный фон
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.pink]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea() // Фон на весь экран

                VStack(spacing: 30) { // Контейнер для размещения элементов
                    // Заголовок
                    Text("Вход в Личный Кабинет")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20) // Отступ снизу

                    // Поле ввода логина
                    TextField("Логин", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .frame(maxWidth: 350) // Максимальная ширина текстового поля

                    // Поле ввода пароля
                    SecureField("Пароль", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .frame(maxWidth: 350) // Максимальная ширина текстового поля

                    // Кнопка входа
                    Button(action: {
                        isLoggedIn = true
                    }) {
                        Text("Войти")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 350, maxHeight: 50) // Размер кнопки
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .navigationDestination(isPresented: $isLoggedIn) {
                        ServicesView()
                    }

                    Spacer() // Отступ снизу
                }
                .padding(.horizontal, 20) // Отступы по бокам
            }
        }
    }
}

// Экран выбора услуг
struct ServicesView: View {
    var body: some View {
        VStack(spacing: 20) { // Размещение кнопок вертикально
            Text("Выберите услугу") // Заголовок экрана
                .font(.title)
                .fontWeight(.bold)

            // Переход к экрану реестра животных
            NavigationLink(destination: AnimalListView()) {
                ServiceButton(title: "Посмотреть реестр животных")
            }

            // Переход к экрану добавления животного
            NavigationLink(destination: AddAnimalView()) {
                ServiceButton(title: "Отдать собаку")
            }

            // Переход к экрану с клиниками
            NavigationLink(destination: ClinicsView()) {
                ServiceButton(title: "Найти клинику")
            }

            // Переход к экрану "О приложении"
            NavigationLink(destination: AboutAppView()) {
                ServiceButton(title: "О приложении")
            }

            // Переход к экрану статистики
            NavigationLink(destination: StatisticsView()) {
                ServiceButton(title: "Статистика")
            }
        }
        .padding()
        .navigationTitle("Услуги") // Заголовок экрана
    }
}

// Кнопки для списка услуг
struct ServiceButton: View {
    let title: String // Текст кнопки

    var body: some View {
        Text(title) // Отображаем текст кнопки
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity) // Растягиваем кнопку по ширине
            .background(Color.green) // Цвет фона кнопки
            .cornerRadius(10) // Округлённые углы
            .shadow(radius: 5) // Тень кнопки
    }
}

// Экран реестра животных
struct AnimalListView: View {
    let animals = [ // Список животных
        Animal(
            name: "Бобик",
            weight: "35 кг",
            size: "50 см",
            imageName: "bobik",
            story: "Бобик был найден на улице после сильного дождя. Его приютили волонтёры и вылечили.",
            origin: "Семья фермеров, которые не смогли содержать его."
        ),
        Animal(
            name: "Шарик",
            weight: "2 кг",
            size: "25 см",
            imageName: "sharik",
            story: "Шарик был оставлен на пороге приюта в маленькой коробке. Сейчас он здоров и ищет дом.",
            origin: "Местная семья, которая переехала за границу."
        ),
        Animal(
            name: "Рекс",
            weight: "28 кг",
            size: "45 см",
            imageName: "reks",
            story: "Рекс — бывший служебный пёс, который помогал в поисково-спасательных операциях.",
            origin: "Питомник для служебных собак."
        ),
        Animal(
            name: "Лайка",
            weight: "40 кг",
            size: "67 см",
            imageName: "laika",
            story: "Лайка попала в приют после того, как её прежние хозяева отказались от неё из-за её большого размера.",
            origin: "Большая семья из деревни."
        ),
        Animal(
            name: "Мухтар",
            weight: "35 кг",
            size: "63 см",
            imageName: "muhtar",
            story: "Мухтар был найден в лесу, где он искал еду. Сейчас он полностью восстановился.",
            origin: "Неизвестно, предположительно из частного дома."
        )
    ]

    var body: some View {
        List(animals) { animal in // Отображаем список животных
            NavigationLink(destination: AnimalDetailView(animal: animal)) { // Переход к деталям животного
                HStack {
                    Image(animal.imageName) // Изображение животного
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle()) // Круглое изображение
                        .shadow(radius: 5)
                    VStack(alignment: .leading) {
                        Text(animal.name) // Имя животного
                            .font(.headline)
                        Text("Вес: \(animal.weight), Размер: \(animal.size)") // Краткая информация
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Реестр животных") // Заголовок экрана
    }
}

// Модель животного
struct Animal: Identifiable {
    let id = UUID() // Уникальный идентификатор
    let name: String // Имя
    let weight: String // Вес
    let size: String // Размер
    let imageName: String // Название изображения
    let story: String // История животного
    let origin: String // Происхождение животного
}

// Экран с деталями животного
struct AnimalDetailView: View {
    let animal: Animal // Данные животного

    var body: some View {
        ScrollView { // Используем ScrollView для прокрутки
            VStack(spacing: 20) {
                Image(animal.imageName) // Изображение животного
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15)) // Округлённое изображение
                    .shadow(radius: 5)

                Text("Информация о питомце") // Заголовок
                    .font(.title)
                    .fontWeight(.bold)

                Text("Имя: \(animal.name)") // Имя
                    .font(.headline)
                Text("Вес: \(animal.weight)") // Вес
                Text("Размер: \(animal.size)") // Размер

                Divider() // Разделительная линия

                Text("История:") // Заголовок раздела
                    .font(.headline)
                Text(animal.story) // История животного
                    .multilineTextAlignment(.leading)

                Divider() // Разделительная линия

                Text("Происхождение:") // Заголовок раздела
                    .font(.headline)
                Text(animal.origin) // Происхождение животного
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .navigationTitle("О питомце") // Заголовок экрана
    }
}

// Экран добавления нового животного
struct AddAnimalView: View {
    @State private var name: String = "" // Имя нового животного
    @State private var weight: String = "" // Вес нового животного
    @State private var size: String = "" // Размер нового животного
    @State private var story: String = "" // История животного
    @State private var isSubmitted = false // Состояние отправки

    var body: some View {
        ScrollView { // Добавляем прокрутку для удобства
            VStack(spacing: 20) {
                Text("Добавить нового питомца") // Заголовок экрана
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                // Статическое изображение для собаки
                Image("placeholder_dog") // Укажите имя изображения, загруженного в Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle()) // Круглая форма изображения
                    .overlay(Circle().stroke(Color.blue, lineWidth: 4)) // Обводка вокруг изображения
                    .shadow(radius: 10)

                // Поле для ввода имени
                TextField("Имя", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Поле для ввода веса
                TextField("Вес", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Поле для ввода размера
                TextField("Размер", text: $size)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Поле для ввода истории животного
                VStack(alignment: .leading) {
                    Text("История питомца")
                        .font(.headline)
                        .padding(.bottom, 5)
                    TextEditor(text: $story)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding()
                }

                // Кнопка отправки данных
                Button(action: {
                    isSubmitted = true // Отправляем данные
                }) {
                    Text("Отправить") // Текст кнопки
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity) // Растягиваем кнопку
                        .background(Color.green) // Цвет кнопки
                        .cornerRadius(10)
                        .shadow(radius: 5) // Тень для кнопки
                }
                .navigationDestination(isPresented: $isSubmitted) { // Переход к экрану подтверждения
                    CompletedView()
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Отдать собаку") // Заголовок экрана
    }
}

// Экран подтверждения
struct CompletedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill") // Иконка подтверждения
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text("Выполнено!") // Сообщение
                .font(.title)
                .fontWeight(.bold)

            // Кнопка для перехода на экран выбора услуг
            NavigationLink(destination: ServicesView()) {
                Text("Вернуться к услугам") // Текст кнопки
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity) // Растягиваем кнопку по ширине
                    .background(Color.blue) // Цвет фона кнопки
                    .cornerRadius(10) // Закруглённые углы
                    .shadow(radius: 5) // Тень кнопки
            }
            .padding(.top, 20) // Отступ сверху
        }
        .padding()
        .navigationTitle("Успешно") // Заголовок экрана
    }
}



// Экран ближайших клиник
struct ClinicsView: View {
    @State private var selectedCity: String = "Москва" // Выбранный город
    @State private var clinics: [Clinic] = [] // Список клиник для выбранного города
    @State private var showDetails: Bool = false // Показывать детали клиники
    @State private var selectedClinic: Clinic? = nil // Выбранная клиника

    let cities = ["Москва", "Санкт-Петербург", "Новосибирск"] // Список городов
    let allClinics: [Clinic] = [ // Все клиники
        Clinic(name: "Клиника здоровья животных", address: "ул. Ленина, 10", city: "Москва", services: ["Вакцинация", "Чипирование", "Стерилизация"]),
        Clinic(name: "Доверие", address: "ул. Гагарина, 25", city: "Москва", services: ["Хирургия", "Терапия", "Рентген"]),
        Clinic(name: "Зооветцентр", address: "ул. Пушкина, 12", city: "Санкт-Петербург", services: ["Вакцинация", "Груминг"]),
        Clinic(name: "Айболит", address: "ул. Мира, 5", city: "Новосибирск", services: ["Чипирование", "Диагностика", "Терапия"])
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Ближайшие клиники") // Заголовок
                .font(.title)
                .fontWeight(.bold)

            // Выбор города
            VStack(alignment: .leading) {
                Text("Выберите город:")
                    .font(.headline)
                Picker("Город", selection: $selectedCity) { // Выпадающее поле для выбора города
                    ForEach(cities, id: \.self) { city in
                        Text(city).tag(city)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Стиль выпадающего меню
                .padding(.horizontal)
                .onChange(of: selectedCity) { // Обновляем список клиник при смене города
                    filterClinics(for: selectedCity)
                }
            }

            // Список клиник
            List(clinics) { clinic in
                Button(action: {
                    selectedClinic = clinic // Устанавливаем выбранную клинику
                    showDetails = true // Показываем детали
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(clinic.name) // Название клиники
                                .font(.headline)
                            Text(clinic.address) // Адрес клиники
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "arrow.right") // Иконка перехода
                            .foregroundColor(.blue)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle()) // Стиль списка

            Spacer()
        }
        .padding()
        .navigationTitle("Клиники") // Заголовок экрана
        .onAppear {
            filterClinics(for: selectedCity) // Фильтруем клиники при загрузке
        }
        .sheet(isPresented: $showDetails) { // Детали клиники в отдельном окне
            if let clinic = selectedClinic {
                ClinicDetailView(clinic: clinic)
            }
        }
    }

    // Фильтрация клиник по городу
    private func filterClinics(for city: String) {
        clinics = allClinics.filter { $0.city == city }
    }
}

// Модель данных для клиники
struct Clinic: Identifiable {
    let id = UUID()
    let name: String // Название клиники
    let address: String // Адрес клиники
    let city: String // Город клиники
    let services: [String] // Услуги, предоставляемые клиникой
}

// Экран с деталями клиники
struct ClinicDetailView: View {
    let clinic: Clinic // Выбранная клиника

    var body: some View {
        VStack(spacing: 20) {
            Text(clinic.name) // Название клиники
                .font(.title)
                .fontWeight(.bold)

            Text("Адрес: \(clinic.address)") // Адрес клиники
                .font(.subheadline)

            Divider() // Разделительная линия

            Text("Доступные услуги:")
                .font(.headline)

            // Список услуг
            ForEach(clinic.services, id: \.self) { service in
                HStack {
                    Image(systemName: "checkmark.circle.fill") // Иконка для услуги
                        .foregroundColor(.green)
                    Text(service) // Название услуги
                }
            }

            Spacer()
        }
        .padding()
    }
}

// Экран "О приложении"
struct AboutAppView: View {
    var body: some View {
        ScrollView { // Прокрутка для длинного контента
            VStack(spacing: 20) {
                // Заголовок
                Text("О приложении")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                // Описание приложения
                VStack(alignment: .leading, spacing: 10) {
                    Text("Приложение помогает учитывать домашних животных и их потребности, предоставляя функционал для работы с данными животных, ближайшими клиниками и аналитикой.")
                        .font(.body)
                        .multilineTextAlignment(.leading)

                    Text("Версия: 1.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()

                Divider() // Разделительная линия

                // Раздел "Разработчики"
                VStack(alignment: .leading, spacing: 20) {
                    Text("Разработчики")
                        .font(.headline)
                        .padding(.bottom, 10)

                    // Информация о первом разработчике
                    DeveloperCardView(
                        name: "Илья Рычков",
                        role: "iOS-разработчик",
                        imageName: "senior-developer" // Укажите имя изображения в Assets
                    )

                    // Информация о втором разработчике
                    DeveloperCardView(
                        name: "Дарья Ефремова",
                        role: "UI/UX-дизайнер",
                        imageName: "junior-developer" // Укажите имя изображения в Assets
                    )
                }
                .padding()

                Divider() // Разделительная линия

                // Дополнительная информация
                VStack(alignment: .leading, spacing: 10) {
                    Text("Полезные ссылки")
                        .font(.headline)

                    Link("Официальный сайт разработчика", destination: URL(string: "https://vk.com/what6ver")!)
                        .font(.body)
                        .foregroundColor(.blue)

                    Link("Руководство пользователя", destination: URL(string: "https://example.com/manual")!)
                        .font(.body)
                        .foregroundColor(.blue)
                }
                .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle("О приложении") // Заголовок экрана
    }
}

// Карточка для отображения разработчика
struct DeveloperCardView: View {
    let name: String // Имя разработчика
    let role: String // Роль разработчика
    let imageName: String // Имя изображения разработчика в Assets

    var body: some View {
        HStack(spacing: 20) {
            Image(imageName) // Изображение разработчика
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle()) // Круглая форма
                .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 5) {
                Text(name) // Имя
                    .font(.headline)

                Text(role) // Роль
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer() // Отступ справа
        }
        .padding()
        .background(Color(UIColor.systemGray6)) // Фон карточки
        .cornerRadius(10) // Округление углов
        .shadow(radius: 5) // Тень
    }
}

// Экран статистики
struct StatisticsView: View {
    // Пример данных для статистики
    let totalAnimals = 5
    let averageWeight = 23
    let largeAnimals = 2
    let smallAnimals = 3
    let vaccinatedAnimals = 4
    let unvaccinatedAnimals = 1

    var body: some View {
        ScrollView { // Прокрутка для длинного контента
            VStack(spacing: 20) {
                // Заголовок
                Text("Статистика")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                // Общая информация
                VStack(alignment: .leading, spacing: 10) {
                    Text("Общая информация")
                        .font(.headline)

                    HStack {
                        StatisticCardView(title: "Всего животных", value: "\(totalAnimals)", color: .green)
                        StatisticCardView(title: "Средний вес", value: "\(averageWeight) кг", color: .blue)
                    }

                    HStack {
                        StatisticCardView(title: "Крупные", value: "\(largeAnimals)", color: .orange)
                        StatisticCardView(title: "Мелкие", value: "\(smallAnimals)", color: .purple)
                    }
                }
                .padding()

                Divider() // Разделительная линия

                // Прогресс вакцинации
                VStack(alignment: .leading, spacing: 10) {
                    Text("Вакцинация")
                        .font(.headline)

                    VStack(alignment: .leading) {
                        Text("Вакцинировано: \(vaccinatedAnimals)/\(totalAnimals)")
                        ProgressView(value: Double(vaccinatedAnimals) / Double(totalAnimals))
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("Не вакцинировано: \(unvaccinatedAnimals)/\(totalAnimals)")
                        ProgressView(value: Double(unvaccinatedAnimals) / Double(totalAnimals))
                            .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    }
                    .padding()
                }
                .padding()

                Divider() // Разделительная линия

                // График распределения
                VStack(alignment: .leading, spacing: 10) {
                    Text("Распределение по весу")
                        .font(.headline)

                    WeightChartView() // График
                        .frame(height: 200)
                        .padding()
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Статистика") // Заголовок экрана
    }
}

// Карточка для отображения статистики
struct StatisticCardView: View {
    let title: String // Название метрики
    let value: String // Значение
    let color: Color // Цвет фона

    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Пример графика распределения по весу
struct WeightChartView: View {
    let weights = [2, 5, 15, 35, 50] // Пример распределения весов животных

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(weights, id: \.self) { weight in
                    VStack {
                        Text("\(weight) кг")
                            .font(.caption)
                            .offset(y: -10) // Сдвигаем текст вверх, чтобы он не налезал на столбец

                        Rectangle()
                            .fill(weight > 30 ? Color.red : Color.green) // Цвет в зависимости от значения
                            .frame(
                                width: (geometry.size.width - CGFloat(weights.count * 10)) / CGFloat(weights.count),
                                height: CGFloat(weight) * 3 // Масштабируем высоту
                            )
                    }
                }
            }
        }
    }
}

