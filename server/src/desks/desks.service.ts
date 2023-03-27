import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDeskDto } from './dto/create-desk.dto';
import { UpdateDeskDto } from './dto/update-desk.dto';
import { Desk } from './entities/desk.entity';

@Injectable()
export class DesksService {
  constructor(
    @InjectRepository(Desk) private desksRepository: Repository<Desk>,
  ) {}
  create(createDeskDto: CreateDeskDto) {
    return this.desksRepository.save({
      name: createDeskDto.name,
      room: createDeskDto.room,
    });
  }

  async findAll(date: String) {
    const dateObj = new Date(date.replace(' ', 'T'));
    const last = dateObj.getDate() - dateObj.getDay() + 8;
    const first = dateObj.getDate() - dateObj.getDay() + 1;
    const startDate = new Date(dateObj.setDate(first));
    const endDate = new Date(dateObj.setDate(last));
    const desks = await this.desksRepository
      .createQueryBuilder('desk')
      .leftJoinAndSelect('desk.reservations', 'reservation')
      .where('reservation.date BETWEEN :startDate AND :endDate', {
        startDate: startDate,
        endDate: endDate,
      })
      .getMany();

    return this.desksRepository.find({ relations: ['reservations'] });
  }

  async findOne(id: number) {
    const desk = await this.desksRepository.findOneBy({ id });
    if (desk) {
      return desk;
    }
    throw new NotFoundException(`Desk with ID ${id} not found.`);
  }

  async update(id: number, updateDeskDto: UpdateDeskDto) {
    const desk = await this.desksRepository.update(id, updateDeskDto);
    if (desk.affected == 0) {
      throw new NotFoundException(`Desk with ID ${id} cannot be updated`);
    }
  }

  async remove(id: number) {
    const desk = await this.desksRepository.delete({ id });
    if (desk.affected == 0) {
      throw new NotFoundException(`Desk with ID ${id} cannot be deleted`);
    }
  }
}
