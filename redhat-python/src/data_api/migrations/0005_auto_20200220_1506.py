# Generated by Django 2.2.6 on 2020-02-20 15:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('data_api', '0004_auto_20200220_1458'),
    ]

    operations = [
        migrations.AlterField(
            model_name='favoritecommand',
            name='company',
            field=models.TextField(),
        ),
        migrations.DeleteModel(
            name='Company',
        ),
    ]
