package database

import "iqj/models"

func (st *Storage) AddAd(ad models.Ad) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	var count int
	err := st.Db.QueryRow(
		"SELECT COUNT(*) FROM ad WHERE Text = $1",
		ad.Text).
		Scan(&count)
	if err != nil {
		return err
	}

	if count == 0 {
		//_, err := st.Db.Exec(
		//	"INSERT INTO ad(id, text, flag) VALUES (&1, &2, &3)"
		//	)
		//if err != nil {
		//
		//}
	} else {
		return nil
	}

	return nil
}

func (st *Storage) GetAd() (*models.Ad, error) {

	return nil, nil
}
