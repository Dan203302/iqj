package database

import "iqj/models"

func (st *Storage) AddAd(ad models.Ad) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	var count int
	err := st.Db.QueryRow(
		"SELECT COUNT(*) FROM ad WHERE text = $1",
		ad.Text).
		Scan(&count)

	if err != nil {
		return err
	}

	if count == 0 {
		_, err = st.Db.Exec(
			"INSERT INTO ad (text) VALUES (&1)",
			ad.Text)
		if err != nil {
			return err
		}

	} else {
		return nil
	}

	return nil
}

func (st *Storage) GetAd(count int) (*[]models.Ad, error) {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	rows, err := st.Db.Query(
		"SELECT id, text FROM ad ORDER BY id DESC LIMIT $1", count)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	var latestAd []models.Ad

	for rows.Next() {
		var id, text string
		err := rows.Scan(&id, &text)

		if err != nil {
			return nil, err
		}
		Ad := models.Ad{
			ID:   id,
			Text: text,
		}
		latestAd = append(latestAd, Ad)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return &latestAd, nil
}
