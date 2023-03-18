import { ConflictException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DesksService } from 'src/desks/desks.service';
import { Repository } from 'typeorm';
import { Reservation } from './entities/reservation.entity';

@Injectable()
export class ReservationsService {
  constructor(
    @InjectRepository(Reservation)
    private reservationRepository: Repository<Reservation>,
    private desksService: DesksService,
  ) {}

  async create(deskId: number, date: Date): Promise<Reservation> {
    const desk = await this.desksService.findOne(deskId);
    if (!desk) {
      throw new Error('Room not found');
    }

    const conflictingReservations = await this.reservationRepository.find({
      where: {
        desk: desk,
        date: date,
      },
    });
    if (conflictingReservations.length > 0) {
      throw new ConflictException(
        'There is already a reservation for this room during this time',
      );
    }

    const reservation = new Reservation();
    reservation.desk = desk;
    reservation.date = date;
    return this.reservationRepository.save(reservation);
  }

  async remove(id: number): Promise<void> {
    await this.reservationRepository.delete(id);
  }
}
