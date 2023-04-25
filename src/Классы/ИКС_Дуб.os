#Использовать autumn
#Использовать cli

&Пластилин
Перем ИКС_ДекораторКоманд;

&Завязь
Функция КонсольноеПриложение(
	&Пластилин(Значение = "КомандаПриложения", Тип = "ТаблицаЗначений") КомандыПриложения,
	&Пластилин КомандаПриложенияПоУмолчанию,
	&Пластилин ОписаниеКонсольногоПриложения	
) Экспорт

	ИмяПриложения = ОписаниеКонсольногоПриложения.ИмяПриложения();
	ПолноеИмяПриложения = ОписаниеКонсольногоПриложения.ПолноеИмяПриложения();
	ВерсияПриложения = ОписаниеКонсольногоПриложения.ВерсияПриложения();

	// TODO: Перенести в ядро ОСени.
	ПолноеИмяПриложения = СтрЗаменить(ПолноеИмяПриложения, "%{cli.ВерсияПриложения}", ВерсияПриложения);

	КонсольноеПриложение = Новый КонсольноеПриложение(
		ИмяПриложения,
		ПолноеИмяПриложения
	);

	КонсольноеПриложение.Версия("v version", ВерсияПриложения);

	Для Каждого ДанныеЖелудя Из КомандыПриложения Цикл

		КомандаПриложения = ДанныеЖелудя.Желудь;
		ОпределениеЖелудя = ДанныеЖелудя.ОпределениеЖелудя;

		Конструктор = ОпределениеЖелудя.Завязь().ДанныеМетода();

		Аннотация = РаботаСАннотациями.НайтиАннотацию(Конструктор.Аннотации, "КомандаПриложения");
		Если Аннотация = Неопределено Тогда
			ВызватьИсключение "Не найдена аннотация КомандаПриложения у желудя " + ДанныеЖелудя.Имя;
		КонецЕсли;

		КонсольноеПриложение.ДобавитьКоманду(
			РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Имя"), 
			РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Описание", ""),
			ИКС_ДекораторКоманд.СоздатьКомандуПоАннотациямОбъекта(ДанныеЖелудя)
		);

	КонецЦикла;

	КонсольноеПриложение.УстановитьОсновноеДействие(КомандаПриложенияПоУмолчанию);

	Возврат КонсольноеПриложение;

КонецФункции

&Дуб
Процедура ПриСозданииОбъекта()
КонецПроцедуры