import datetime
import random, string

my_file = open("out.txt", "w")

def random_string(length: int):
    letters = string.ascii_lowercase + string.digits
    return ''.join(random.choice(letters) for _ in range(length))


def random_coordinates_widht():
    return str(round(random.uniform(55, 65), 5))


def random_coordinates_longitude():
    return str(round(random.uniform(40, 60), 5))


def gen_datetime(min_year=2010, max_year=datetime.datetime.now().year):
    # generate a datetime in format yyyy-mm-dd hh:mm:ss.000000
    start = datetime.datetime(min_year, 1, 1, 00, 00, 00)
    years = max_year - min_year + 1
    end = start + datetime.timedelta(days=365 * years)
    return str(start + (end - start) * random.random())[0:19]


def generate_insert_human(num: int):
    s = "INSERT INTO Human (name, surname, age) \nVALUES"
    for i in range(num):
        s += "(\'" + random_string(10) + \
             "\',\'" + random_string(10) + \
             "\'," + str(random.randint(10, 50)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_operative(num: int):
    s = "INSERT INTO Operative (call_sign, specialization, grade, id_human) \nVALUES"
    rank = ['рядовой', 'ефрейтор', 'младший сержант', 'сержант', 'рядовой', 'старший сержант', 'старшина', 'прапорщик',
            'старший прапорщик', 'младший лейтенант', 'лейтенант', 'старший лейтенант', 'капитан', 'майор',
            'подполковник', 'полковник', 'генерал-майор', 'генерал-лейтенант', 'генерал-полковник']
    for i in range(num):
        s += "(\'" + random_string(10) + \
             "\',\'" + random_string(10) + \
             "\',\'" + rank[random.randint(0, len(rank) - 1)] + \
             "\'," + str(i + 1) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_location(num: int):
    s = "INSERT INTO Location (name, zone, widht, longitude) \nVALUES"
    ZONE = ["Зеленая зона", "Желтая зона", "Красная зона", "Эпицентр"]
    for i in range(num):
        s += "(\'" + random_string(10) + \
             "\',\'" + ZONE[random.randint(0, 3)] + \
             "\'," + random_coordinates_widht() + \
             "," + random_coordinates_longitude() + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_brigade(num: int, location_id_count: int):
    s = "INSERT INTO Brigade (name, id_location) \nVALUES"
    for i in range(num):
        s += "(\'" + random_string(15) + \
             "\'," + str(random.randint(1, location_id_count)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_citizen(num: int, num_brigade: int):
    s = "INSERT INTO Citizen (call_sigh, id_brigade, id_human) \nVALUES"
    for i in range(num):
        s += "(\'" + random_string(10) + \
             "\'," + str(random.randint(1, num_brigade)) + \
             "," + str(i + num + 1) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_anomaly(num: int, num_location: int, num_operative: int):
    s = "INSERT INTO Anomaly (name, zone, widht, longitude, id_location, id_operative, size) \nVALUES"
    ZONE = ["Зеленая зона", "Желтая зона", "Красная зона", "Эпицентр"]
    ANOMALY = ["Воронка", "Газовая Аномалия", "Грава", "Жаровня", "Жернова", "Зыбь", "Лизун", "Магнит", "Миротворец",
               "Мясорубка", "Оковы", "Паутина", "Плешь", "Пух", "Пушка", "Раздиратель", "Рулетка", "Свечение"
        , "Сито", "Соленоид", "Студень", "Туча", "Центрифуга"]
    SIZE = ["большая", "средняя", "маленькая", "крохотная"]
    for i in range(num):
        s += "(\'" + ANOMALY[random.randint(0, len(ANOMALY) - 1)] + \
             "\',\'" + ZONE[random.randint(0, 3)] + \
             "\'," + random_coordinates_widht() + \
             "," + random_coordinates_longitude() + \
             "," + str(random.randint(1, num_location)) + \
             "," + str(random.randint(1, num_operative)) + \
             ",\'" + SIZE[random.randint(0, 3)] + "\'),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_equipment(num: int, num_operative: int):
    s = "INSERT INTO Equipment (name, description, id_operative) \nVALUES"
    for i in range(num):
        s += "(\'" + random_string(10) + \
             "\',\'" + random_string(20) + \
             "\'," + str(random.randint(1, num_operative)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_met(num: int, num_operative: int, num_location: int):
    s = "INSERT INTO Metamorphite (id_location, id_operative, name, zone, widht, longitude) \nVALUES"
    METS = ["Осколок", "Ариадна", "Банка", "Грелка", "Дозиметр", "Живая Вода", "Жук", "Зеленка",
            "Компас", "Медсестра", "Невидимка", "Отмычка", "Пиявка", "Пластырь", "Примус", "Пустышка",
            "Родник", "Светлячок", "Старатель", "Тишь", "Филин", "Шестое чувство", "Энерджайзер", "Адреналин"]
    ZONE = ["Зеленая зона", "Желтая зона", "Красная зона", "Эпицентр"]
    for i in range(num):
        s += "(" + str(random.randint(1, num_location)) + \
             "," + str(random.randint(1, num_operative)) + \
             ",\'" + METS[random.randint(0, len(METS) - 1)] + \
             "\',\'" + ZONE[random.randint(0, 3)] + \
             "\'," + random_coordinates_widht() + \
             "," + random_coordinates_longitude() + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_operation(num: int, num_location: int):
    s = "INSERT INTO Operation (name, date, id_location) \nVALUES"
    for i in range(num):
        s += "(\'" + random_string(15) + \
             "\',\'" + gen_datetime() + \
             "\'," + str(random.randint(1, num_location)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_owner_eqp(num: int, num_equip: int, num_oper: int):
    s = "INSERT INTO Owners_eqp (id_equipment, id_operative) \nVALUES"
    for i in range(num):
        s += "(" + str(random.randint(1, num_equip)) + \
             "," + str(random.randint(1, num_oper)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_squad(num_oper: int):
    s = "INSERT INTO Squad (id_operative, id_commander) \nVALUES"
    for i in range(num_oper):
        s += "(" + str(i + 1) + \
             "," + str(random.randint(1, num_oper // 10)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_owner_met(num: int, num_met: int, num_oper: int):
    s = "INSERT INTO Owners_met (id_operative, id_metamorphite) \nVALUES"
    for i in range(num):
        s += "(" + str(random.randint(1, num_oper)) + \
             "," + str(random.randint(1, num_met)) + "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


def generate_insert_kill(num: int, num_citizen: int, num_oper: int):
    s = "INSERT INTO Kill (id_citizen, id_operative, name) \nVALUES"
    meow = ["TRUE", "FALSE"]
    for i in range(num):
        s += "(" + str(random.randint(1, num_citizen)) + \
             "," + str(random.randint(1, num_oper)) + \
             "," + meow[random.randint(0,1)]+ "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s

def generate_insert_captive(num: int, num_citizen: int, num_oper: int):
    s = "INSERT INTO Captive (id_citizen, id_operative, name) \nVALUES"
    meow = ["TRUE", "FALSE"]
    for i in range(num):
        s += "(" + str(random.randint(1, num_citizen)) + \
             "," + str(random.randint(1, num_oper)) + \
             "," + meow[random.randint(0,1)]+ "),\n"
    s = s[:len(s) - 2] + ";" + s[len(s) - 1:]
    return s


my_file.write(generate_insert_human(10000)+ "\n")
my_file.write(generate_insert_operative(5000) + "\n")
my_file.write(generate_insert_location(500)+ "\n")
my_file.write(generate_insert_brigade(20,500)+ "\n")
my_file.write(generate_insert_citizen(5000, 20)+ "\n")
my_file.write(generate_insert_anomaly(50000, 500, 5000)+ "\n")
my_file.write(generate_insert_equipment(80000, 5000)+ "\n")
my_file.write(generate_insert_met(30000, 5000, 500)+ "\n")
my_file.write(generate_insert_operation(1000, 500)+ "\n")
my_file.write(generate_insert_owner_eqp(60000, 30000, 5000)+ "\n")
my_file.write(generate_insert_squad(5000)+ "\n")
my_file.write(generate_insert_owner_met(60000, 30000, 5000)+ "\n")
my_file.write(generate_insert_kill(400, 5000, 5000)+ "\n")
my_file.write(generate_insert_captive(500, 5000, 5000)+ "\n")

my_file.close()
