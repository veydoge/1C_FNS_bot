﻿&НаСервере
Функция Получить() Экспорт // тут я получаю случайное первое сообщение из первого обсуждения 
	Перем СписокТоваров, СчетчикСтрок;
	
	
	ОтборОбсуждений = Новый ОтборОбсужденийСистемыВзаимодействия();
	Обсуждения = СистемаВзаимодействия.ПолучитьОбсуждения(ОтборОбсуждений);
	ОтборСообщений = Новый ОтборСообщенийСистемыВзаимодействия();  
	ПоследнееСообщениеИд = Новый ИдентификаторСообщенияСистемыВзаимодействия(Константы.ИдентификаторПоследнего.Получить());
	ОтборСообщений.После = ПоследнееСообщениеИд;     
	ПоследнееСообщение = СистемаВзаимодействия.ПолучитьСообщение(ПоследнееСообщениеИд);
	Обсуждение = Обсуждения[0];
	ОтборСообщений.Обсуждение = Обсуждение.Идентификатор;   
	Сообщения = СистемаВзаимодействия.ПолучитьСообщения(ОтборСообщений); 
	
	//идентфикатор записывать в переменную
	
	
	Для каждого Сообщение из Сообщения Цикл
		Попытка    
		

		ПоследнееСообщение =Сообщение.Идентификатор;
		 
		 
		СтрокиЧека = СтрРазделить(Сообщение.Текст, Символы.ПС, Ложь);
	 		 
		 // Парсинг касающийся даты
		 
		СтрокаДаты = СтрРазделить(СтрокиЧека[1], ":")[1] + " " + СтрРазделить(СтрокиЧека[1], ":")[2]; 
		ИтоговаяДата = РаспарситьДату(СтрокаДаты); 
		 		     
		//
		
		Отправитель = СтрРазделить(СтрокиЧека[0], ":")[1];
		Отправитель = СтрРазделить(СокрЛП(Отправитель), " "); 
		Отправитель.Удалить(0);
		Отправитель = СтрСоединить(Отправитель, " ");
		
		ИНН = СтрРазделить(СтрокиЧека[2], ":");   
		
		
		ТоварыИСчетчик = ПолучитьСписокТоваров(СтрокиЧека); 
		ТоварыИСчетчик.Свойство("СписокТоваров", СписокТоваров);
		ТоварыИСчетчик.Свойство("СчетчикСтрок", СчетчикСтрок);

		
		
		
		
		Итого = СтрРазделить(СтрокиЧека[СчетчикСтрок], ":");
		Наличные = СтрРазделить(СтрокиЧека[СчетчикСтрок + 1], ": ", Ложь)[1];
		Безналичные = СтрРазделить(СтрокиЧека[СчетчикСтрок + 2], ": ", Ложь)[1];
		Если СтрРазделить(СтрокиЧека[СчетчикСтрок + 3], ":", Ложь)[0] = "НДС итога чека со ставкой 10%" Тогда
			СчетчикСтрок = СчетчикСтрок + 1;
		КонецЕсли;
		
		НомерСмены = СтрРазделить(СтрокиЧека[СчетчикСтрок + 3], ": ", Ложь)[2];  
		Кассир = "";
		Если СтрРазделить(СтрокиЧека[СчетчикСтрок +4], ":")[0] = "Кассир" Тогда
			Кассир = СтрРазделить(СтрокиЧека[СчетчикСтрок +4], ":")[1];
			СчетчикСтрок = СчетчикСтрок + 1;
		КонецЕсли;
		
		МестоРасчётов = СтрРазделить(СтрокиЧека[СчетчикСтрок +4], ":");
		АдресРасчётов = СтрРазделить(СтрокиЧека[СчетчикСтрок + 5], ":");
		НомерЧека = СтрРазделить(СтрокиЧека[СчетчикСтрок + 6], ": ", Ложь)[2];
		СНО = СтрРазделить(СтрокиЧека[СчетчикСтрок + 7], ":");
		РНККТ = СтрРазделить(СтрокиЧека[СчетчикСтрок + 8], ":");
		ФН = СтрРазделить(СтрокиЧека[СчетчикСтрок + 9], ":");
		ФД = СтрРазделить(СтрокиЧека[СчетчикСтрок + 10], ":");
		ФП = СтрРазделить(СтрокиЧека[СчетчикСтрок + 11], ":");  
		 
		 //
		 
		НовыйЧек = Документы.Чеки.СоздатьДокумент();
				
		НовыйЧек.Дата = ИтоговаяДата; 
		НовыйЧек.Итого = Итого[1];
		НовыйЧек.Наличные = Число(СокрЛП(Наличные));
		НовыйЧек.Безналичные = Число(СокрЛП(Безналичные));
		НовыйЧек.НомерСмены = Число(СокрЛп(НомерСмены)); 
		НовыйЧек.Кассир = Кассир;
		НовыйЧек.МестоРасчетов = МестоРасчётов[1];
		НовыйЧек.АдресРасчетов = АдресРасчётов[1];
		НовыйЧек.НомерЧека = Число(СокрЛП(НомерЧека));
		НовыйЧек.СНО = СНО[1];
		НовыйЧек.РНККТ = РНККТ[1];
		НовыйЧек.ФН = ФН[1];
		НовыйЧек.ФД = ФД[1];
		НовыйЧек.ФП = ФП[1];
		 
		 
		
		 
		 //  
		Статус = Справочники.Контрагенты.НайтиПоНаименованию(Отправитель); // добавление контрагента, если ранее такого не было
		Если Статус = Справочники.Контрагенты.ПустаяСсылка() Тогда
			НовыйКонтрагент = Справочники.Контрагенты.СоздатьЭлемент(); 
			НовыйКонтрагент.Наименование = Отправитель;
			НовыйКонтрагент.ИНН = Число(ИНН[1]);
			НовыйКонтрагент.Записать();
			НовыйЧек.Контрагент = НовыйКонтрагент.Ссылка;
		Иначе
			НовыйЧек.Контрагент = Статус;
		КонецЕсли;	
		
		Для Каждого Товар из СписокТоваров Цикл
			ТоварВТаблице = НовыйЧек.Товары.Добавить();
			ЗаполнитьЗначенияСвойств(ТоварВТаблице, Товар);
			
		КонецЦикла;
		
				
		НовыйЧек.Записать();
		
			
		Исключение
			 Сообщить(ОписаниеОшибки());
		КонецПопытки;
	Константы.ИдентификаторПоследнего.Установить(Сообщение.Идентификатор);
		 
	КонецЦикла;
	Возврат "";
	// Возврат Сообщения[0].Текст;
КонецФункции

&НаСервере
Функция ПолучитьСписокТоваров(Знач СтрокиЧека)
	
	Перем НовыйТовар, СписокТоваров, СтрокаСуммы;
	
	СписокТоваров = Новый Массив();
	СчетчикСтрок = 3;
	Пока СтрРазделить(СтрокиЧека[СчетчикСтрок], ":")[0] <> "Итого" Цикл
		Если СчетчикСтрок % 2 = 1 Тогда
			НовыйТовар = Новый Структура();
			НовыйТовар.Вставить("Наименование", СтрРазделить(СтрокиЧека[СчетчикСтрок], " ")[1]);
			
		Иначе
			
			СтрокаСуммы = СтрРазделить(СтрокиЧека[СчетчикСтрок], " ");
			НовыйТовар.Вставить("Цена", СтрокаСуммы[0]);
			НовыйТовар.Вставить("Количество", СтрокаСуммы[2]);
			НовыйТовар.Вставить("Сумма", СтрокаСуммы[4]);
			СписокТоваров.Добавить(НовыйТовар)
		КонецЕсли;
		СчетчикСтрок = СчетчикСтрок + 1;
	КонецЦикла;    
	
	ТоварыИСчетчик = Новый Структура();
	ТоварыИСчетчик.Вставить("СписокТоваров", СписокТоваров);
	ТоварыИСчетчик.Вставить("СчетчикСтрок", СчетчикСтрок);
	Возврат ТоварыИСчетчик;

КонецФункции   

Функция РаспарситьДату(СтрокаДаты) // парсить строку вида день.месяц.год часы:минуты в дату
		СтрокаДаты = СокрЛП(СтрокаДаты);
		СтрокаДаты = СтрЗаменить(СтрокаДаты, ".", " ");
		СтрокаДаты = СтрЗаменить(СтрокаДаты, ":", " "); 
		МассивСтрок = СтрРазделить(СтрокаДаты, " ");
		  
		Год = Число(МассивСтрок[2]);
		Месяц = Число(МассивСтрок[1]);
		День = Число(МассивСтрок[0]);
		Час = Число(МассивСтрок[3]);
		Минута = Число(МассивСтрок[4]);
		
		ИтоговаяДата = Дата(Год, Месяц, День, Час, Минута, 0);
		
		Возврат ИтоговаяДата;

КонецФункции