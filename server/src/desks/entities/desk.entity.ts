import { Reservation } from 'src/reservations/entities/reservation.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Desk {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  room: string;

  @OneToMany(() => Reservation, (reservation) => reservation.desk)
  reservations: Reservation[];
}
