-- средняя стоимость 1 кв метра по каждому этажу
select floor,avg(cost / sguere) from Object group by floor 
-- изменить номер этажа 
select  floor,
case 
when floor =1 then '1й этаж'
when floor = 2 then '2 й этаж'
when floor = 3 then '3 й этаж'
else 'error'
end as floorTypewithElse
from Object


--вывести риелторов которые продали объект меньше чем за 4 мес
--риелторов продавших объекты в двух и более районов 
select rieltor_code,count (area) from Salaries inner join Object on salarie_code=1
group by rieltor_code having count(area) >=2

--риелторов вывести которые сделали меньше 5 продаж в прошлом году 
select name,surname ,count(salarie_code) from Salaries inner join Rieltor on salarie_code =1 and 
extract year from salarie_date = 2022 group by name,surname having count(salarie_code)<5

-- laba 4
--16 квартиры которые были в продаже не позже чем 4 мес назад
 select address from Object where type like '%flat%' and extract
 age(month from date(Object.date_obiavl,Salaries.salarie_date)) <4 

--15 Вывести количество объектов недвижимости по каждому району,
--общая площадь которых больше 40 м2 . использ таблицу структура объекта недвиж
 select area ,count(*) from products,Object(select products.sguere_n ) as A,
sum(Object.sguere) as sum  group by area 

--14 инф о комнатах объекта недвижимости
 select name,sguere_n from products

--12 индекс средней оценки по каждому критерию для указанного объекта недвижимости
--вывести  среднюю оценку и эквивалентный текст
 select avg(mark) , criterie_name
 case 
when mark <60% then 'bad'
when mark >=60% and mark < 70 then 'udovl'
when mark >=70% and mark < 80% then 'good'
when mark >=80% and mark < 90% then 'very good'
when mark > 90% then 'perfect'
else 'error'
from Marks cross join Criteries group by mark


  --11 кол во однокомнатных и двукомнатных квартир в районе
    select case rooms_number
when 1 then '1 room flat'
when 2 then '2 room flat'
else 'over 3 rooms'
end type,count (rooms_number)
from Object where area like '%leninsky%' and type like '%flat%' group by rooms_number 


--8 названия районов со средней площадью больше 30 
 select area,avg(sguere) from Object inner join Salaries on salarie_code = 1 group by area having avg(sguere) >30

--7 фио риелторов которые в этом году ничего не продали
 select name,surname,extract(year from salarie_date),count(salarie_code) from Rieltor inner join Salaries on salarie_code =1 group by name,surname having count(salarie_code)<1

--5  годы в которые было размещено от 2 до 3 объектов
select extract (year from date_obiavl) ,count(object_code) from Object group by date_obiavl having count(object_code)<4 and count(object_code)>1

--4 фио риелторов ,продавших меньше 5 объектов
select name,surname,count(salarie_code) from Rieltor inner join Salaries on salarie_code =1 group by name,surname having count(salarie_code)<5

--2 названия районов,в которых количество проданных квартир меньше 5
 select area ,count(object_code) from Object where status = 1 group by area having count(object_code)<5

--laba 3

--10 общая стоимость аппартаментов в диапазоне дат по каждому риелтору. проблема с
--присоединением третьей таблицы Object для сортировки по типу 'aparts' т е апартаменты,
--не знаю как это сделать

select name,surname,sum(salarie_price) from Salaries inner join Rieltor on salarie_date
 <'20.09.2024' and salarie_date >'20.09.2008' and type like '%aparts%' group by name

--12средняя площадь квартир по каждому району
 select area,avg(sguere) from Object where type like '%flat%' group by area

--13  минимальная и максимальная оценка объектов по критерию для объекта недвижимости
 select criterie_name,min(mark),max(mark) from Criteries cross join Marks   group by criterie_name
 

 --14 количество объектов по количеству комнат проданных по стоимости выше 1000
  select rooms_number,count(object_code) from Object inner join Salaries on  salarie_price - cost >1000  group by rooms_number 

--15 средняя стоимость квартир с описанием 'amazing' по району
 select  area,avg(cost) from object where type like '%flat%' and object_descr like '%amazing%' group by area

--5 максимальная стоимость квартир по каждому району
 select area,max(cost) from Object where type like '%flat%' group by area

--4 средняя стоимость объектов на 2 м этаже по каждому материалу здания
 select material,avg(cost) from Object where floor = 2 group by material

--3 количество двукомнатных объектов по каждому типу
select type,count(object_code) from Object where rooms_number=2 group by type

--2 количество объектов по каждому району
select area,count(object_code) from Object group by area


--laba 2
--12 вывести фио риелтора,разницу между заявленной и продажной стоимостью. нужно присоединить
--третью таблицу Rieltor. не могу понять как это сделать

select name,surname max(salarie_cost)-min(cost) as 'difference' from Object inner join Salaries on Object.cost = Salaries.salarie_cost 
 inner join Rieltor on Rieltor.name = Salaries.salarie_cost where Object.floor = 2

--15 объекты с типом квартира проданные указанным риелтором и стоимостью выше 100
 select address,floor,rooms_number from Object inner join Rieltor on type like '%flat%' and surname like '%ivanov%' and cost >100; 

--14 двукомнатные объекты с критерием 'чисто'
 select address,area,type from Object inner join Criteries on rooms_number = 2 and criterie_name like '%clean%'


--5 объект с типом квартира в указанном районе с площадью больше 20
select address,object_descr from Object where type like '%flat%' and sguere >20 and area like '%leninsky%'


--4 объекты с типом квартира и площадью больше 1
  select address,cost,material from Object where sguere > 1 and type like '%flat%'


--3 объекты добавленные после указанной даты и площадью больше 10
 select address,floor,rooms_number,area from Object where  sguere > 10 and date_obiavl >'20.10.2017'


--2 двукомнатные объекты с площадью больше 20
 select address,floor,type from Object where rooms_number=2 and sguere >20


--1 стоимость и адреса объектов на втором этаже
  select cost,address from Object where floor = 2










