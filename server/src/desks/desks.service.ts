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

  findAll() {
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
